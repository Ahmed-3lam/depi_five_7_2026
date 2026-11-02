import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:depi_five/core/helpers/network/api_const.dart';
import 'package:depi_five/core/helpers/network/network_helper.dart';
import 'package:depi_five/features/home/model/banner_model.dart';
import 'package:depi_five/features/home/model/product_model.dart';
import 'package:flutter/foundation.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({FirebaseFirestore? firestore})
    : _firestore = firestore,
      super(HomeInitial());

  final FirebaseFirestore? _firestore;
  BannerModel bannerModel = BannerModel();
  ProductModel productModel = ProductModel();

  /// Retained API source; home currently uses [fetchBannersFromFirestore].
  void fetchBanners() async {
    emit(HomeBannersLoadingState());
    try {
      final result = await NetworkHelper.getData(path: ApiConst.banners);
      bannerModel = BannerModel.fromJson(result.data);
      if (bannerModel.statusCode == 200) {
        emit(HomeBannersSuccessState(bannerModel: bannerModel));
      } else {
        emit(HomeBannersErrorState());
      }
    } catch (e) {
      emit(HomeBannersErrorState());
    }
  }

  Future<void> fetchBannersFromFirestore() async {
    if (isClosed) return;
    emit(HomeBannersLoadingState());
    try {
      final result = await (_firestore ?? FirebaseFirestore.instance)
          .collection('banners')
          .where('isActive', isEqualTo: true)
          .get();
      final banners =
          result.docs
              .map((doc) => BannerData.fromFirestore(doc.id, doc.data()))
              .where((banner) => banner.image?.trim().isNotEmpty ?? false)
              .toList()
            ..sort((a, b) {
              final priority = (a.priority ?? 0).compareTo(b.priority ?? 0);
              return priority != 0
                  ? priority
                  : a.documentId!.compareTo(b.documentId!);
            });
      if (isClosed) return;
      bannerModel = BannerModel(data: banners);
      emit(HomeBannersSuccessState(bannerModel: bannerModel));
    } catch (_) {
      if (isClosed) return;
      emit(HomeBannersErrorState());
    }
  }

  Future<void> fetchProductsFromFirestore() async {
    if (isClosed) return;
    emit(HomeProductsLoadingState());
    try {
      final result = await (_firestore ?? FirebaseFirestore.instance)
          .collection('products')
          .where('isActive', isEqualTo: true)
          .get();
      final products =
          result.docs
              .map((doc) => Products.fromFirestore(doc.id, doc.data()))
              .toList()
            ..sort((a, b) {
              final id = (a.id ?? 0).compareTo(b.id ?? 0);
              return id != 0 ? id : a.documentId!.compareTo(b.documentId!);
            });
      if (isClosed) return;
      productModel = ProductModel(data: ProductData(products: products));
      emit(HomeProductsSuccessState());
    } catch (_) {
      if (isClosed) return;
      emit(HomeProductsErrorState());
    }
  }

  /// Retained API source; home currently uses [fetchProductsFromFirestore].
  void fetchProducts() async {
    emit(HomeProductsLoadingState());
    try {
      final result = await NetworkHelper.getData(path: ApiConst.products);
      productModel = ProductModel.fromJson(result.data);
      if (productModel.statusCode == 200) {
        emit(HomeProductsSuccessState());
      } else {
        emit(HomeProductsErrorState());
      }
    } catch (e) {
      emit(HomeProductsErrorState());
    }
  }
}
