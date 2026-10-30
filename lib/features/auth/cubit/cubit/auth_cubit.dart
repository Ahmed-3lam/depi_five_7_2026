import 'package:bloc/bloc.dart';
import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:depi_five/core/helpers/network/api_const.dart';
import 'package:depi_five/core/helpers/network/network_helper.dart';
import 'package:depi_five/features/auth/model/login_model.dart';
import 'package:depi_five/features/home/view/home_page.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  LoginModel loginModel = LoginModel();
  
  void login(String email, String pass) async {
    emit(AuthLoading());
    try {
      final result = await NetworkHelper.postData(
        path: ApiConst.login,
        body: {"email": email, "password": pass},
      );
      loginModel = LoginModel.fromJson(result.data);

      if (loginModel.statusCode == 200) {
        ///Navigato To home
        HiveHelper.setToken(loginModel.data?.token ?? "");
        Get.offAll(HomePage());

        emit(AuthSuccess());
      } else {
        Get.snackbar(
          "Error",
          loginModel.message ?? "",
          backgroundColor: Colors.red,
        );
        emit(AuthError());
      }
    } catch (e) {
      print(e.toString());
      emit(AuthError());
    }
  }
}
