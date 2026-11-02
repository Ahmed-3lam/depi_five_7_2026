import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_five/features/home/cubit/cubit/home_cubit.dart';
import 'package:depi_five/features/home/model/product_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'loads all 100 active products in ID order with numeric prices',
    () async {
      final firestore = FakeFirebaseFirestore();
      final collection = firestore.collection('products');
      final createdAt = DateTime.utc(2026, 11, 2);
      for (var id = 100; id > 0; id--) {
        await collection.doc('product-$id').set({
          'id': id,
          'name': 'Product $id',
          'description': 'Description $id',
          'price': id.isEven ? id : id + 0.5,
          'rating': id.isEven ? 4 : 4.5,
          'image': 'https://example.com/product-$id.jpg',
          'categoryId': 1,
          'stock': 20,
          'reviews': 3,
          'brand': 'Demo',
          'isActive': true,
          'createdAt': Timestamp.fromDate(createdAt),
        });
      }
      await collection.doc('inactive').set({'id': 0, 'isActive': false});
      final cubit = HomeCubit(firestore: firestore);
      addTearDown(cubit.close);
      final states = <HomeState>[];
      final subscription = cubit.stream.listen(states.add);
      addTearDown(subscription.cancel);

      await cubit.fetchProductsFromFirestore();
      await Future<void>.delayed(Duration.zero);

      expect(states, [
        isA<HomeProductsLoadingState>(),
        isA<HomeProductsSuccessState>(),
      ]);
      final products = cubit.productModel.data!.products!;
      expect(products, hasLength(100));
      expect(
        products.map((product) => product.id),
        List.generate(100, (i) => i + 1),
      );
      expect(products.first.documentId, 'product-1');
      expect(products.first.name, 'Product 1');
      expect(products.first.price, 1.5);
      expect(products[1].price, 2.0);
      expect(products[1].rating, 4.0);
      expect(products.first.stock, 20);
      expect(products.first.createdAt, createdAt.toIso8601String());
    },
  );

  test('empty products collection succeeds', () async {
    final cubit = HomeCubit(firestore: FakeFirebaseFirestore());
    addTearDown(cubit.close);

    await cubit.fetchProductsFromFirestore();

    expect(cubit.state, isA<HomeProductsSuccessState>());
    expect(cubit.productModel.data!.products, isEmpty);
  });

  test('bad product data can be corrected and retried', () async {
    final firestore = FakeFirebaseFirestore();
    final document = firestore.collection('products').doc('invalid');
    await document.set({
      'name': 'Product',
      'price': 'invalid',
      'isActive': true,
    });
    final cubit = HomeCubit(firestore: firestore);
    addTearDown(cubit.close);

    await cubit.fetchProductsFromFirestore();
    expect(cubit.state, isA<HomeProductsErrorState>());

    await document.update({'price': 10});
    await cubit.fetchProductsFromFirestore();
    expect(cubit.state, isA<HomeProductsSuccessState>());
    expect(cubit.productModel.data!.products!.single.price, 10.0);
  });

  test('closing during a products read does not emit after closure', () async {
    final cubit = HomeCubit(firestore: FakeFirebaseFirestore());
    final pendingRead = cubit.fetchProductsFromFirestore();
    await cubit.close();

    await expectLater(pendingRead, completes);
    await expectLater(cubit.fetchProductsFromFirestore(), completes);
  });

  test('API product parsing still supports integer and decimal prices', () {
    final model = ProductModel.fromJson({
      'status_code': 200,
      'data': {
        'products': [
          {'id': 1, 'price': 10, 'rating': 4},
          {'id': 2, 'price': 10.5, 'rating': 4.5},
        ],
        'pagination': {'page': 1, 'limit': 10, 'total': 2, 'pages': 1},
      },
    });

    expect(model.statusCode, 200);
    expect(model.data!.products!.map((product) => product.price), [10.0, 10.5]);
    expect(model.data!.pagination!.total, 2);
  });
}
