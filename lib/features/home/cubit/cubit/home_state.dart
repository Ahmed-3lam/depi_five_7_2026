part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeBannersLoadingState extends HomeState {}

final class HomeBannersSuccessState extends HomeState {
BannerModel bannerModel;
  HomeBannersSuccessState({required this.bannerModel});
}

final class HomeBannersErrorState extends HomeState {}



final class HomeProductsLoadingState extends HomeState {}

final class HomeProductsSuccessState extends HomeState {}

final class HomeProductsErrorState extends HomeState {}