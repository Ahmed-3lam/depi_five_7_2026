import 'package:bloc/bloc.dart';
import 'package:depi_five/core/helpers/network/api_const.dart';
import 'package:depi_five/core/helpers/network/network_helper.dart';
import 'package:depi_five/features/home/model/banner_model.dart';
import 'package:depi_five/features/home/model/product_model.dart'
    show ProductModel;
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  BannerModel bannerModel = BannerModel();
  ProductModel productModel = ProductModel();

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
