import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_five/features/home/cubit/cubit/home_cubit.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'loads active Firestore banners by priority with document IDs',
    () async {
      final firestore = FakeFirebaseFirestore();
      final collection = firestore.collection('banners');
      await collection.doc('second').set({
        'title': 'Second',
        'image': 'https://example.com/second.jpg',
        'isActive': true,
        'priority': 2,
        'createdAt': Timestamp.fromDate(DateTime.utc(2026, 11, 2)),
      });
      await collection.doc('first').set({
        'image': 'https://example.com/first.jpg',
        'isActive': true,
        'priority': 1,
      });
      await collection.doc('inactive').set({
        'image': 'https://example.com/inactive.jpg',
        'isActive': false,
        'priority': 0,
      });
      await collection.doc('missing-image').set({'isActive': true});
      final cubit = HomeCubit(firestore: firestore);
      addTearDown(cubit.close);
      final states = <HomeState>[];
      final subscription = cubit.stream.listen(states.add);
      addTearDown(subscription.cancel);

      await cubit.fetchBannersFromFirestore();
      await Future<void>.delayed(Duration.zero);

      expect(states, [
        isA<HomeBannersLoadingState>(),
        isA<HomeBannersSuccessState>(),
      ]);
      expect(cubit.bannerModel.data!.map((banner) => banner.documentId), [
        'first',
        'second',
      ]);
      expect(
        cubit.bannerModel.data!.last.createdAt,
        '2026-11-02T00:00:00.000Z',
      );
    },
  );

  test('empty collection succeeds with no banners', () async {
    final cubit = HomeCubit(firestore: FakeFirebaseFirestore());
    addTearDown(cubit.close);

    await cubit.fetchBannersFromFirestore();

    expect(cubit.state, isA<HomeBannersSuccessState>());
    expect(cubit.bannerModel.data, isEmpty);
  });

  test(
    'invalid banner emits an error and can be retried after correction',
    () async {
      final firestore = FakeFirebaseFirestore();
      final document = firestore.collection('banners').doc('invalid');
      await document.set({
        'isActive': true,
        'image': 'https://example.com/banner.jpg',
        'priority': 'invalid',
      });
      final cubit = HomeCubit(firestore: firestore);
      addTearDown(cubit.close);

      await cubit.fetchBannersFromFirestore();
      expect(cubit.state, isA<HomeBannersErrorState>());

      await document.update({'priority': 1});
      await cubit.fetchBannersFromFirestore();
      expect(cubit.state, isA<HomeBannersSuccessState>());
      expect(cubit.bannerModel.data!.single.documentId, 'invalid');
    },
  );

  test('closing during a read does not emit after closure', () async {
    final cubit = HomeCubit(firestore: FakeFirebaseFirestore());
    final pendingRead = cubit.fetchBannersFromFirestore();
    await cubit.close();

    await expectLater(pendingRead, completes);
  });
}
