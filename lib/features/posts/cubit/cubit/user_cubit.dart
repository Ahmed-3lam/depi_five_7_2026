import 'package:bloc/bloc.dart';
import 'package:depi_five/features/posts/model/user.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  List<UserModel> users = [];

  Future<void> fetchPosts() async {
    
    emit(UserLoadingState());
    try {
      final response = await Dio(
        BaseOptions(headers: {"Content-Type": "application/json"}),
      ).get("https://dummyjson.com/users");

      List apiList = response.data["users"];
      users = apiList.map((e) => UserModel.fromJson(e)).toList();
      emit(UserSuccessState());
    } catch (e) {
      emit(UserErrorState());
      print(e);
    }
  }
}
