import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_amit_56/core/dio_helper.dart';
import 'package:pagination_amit_56/core/local/shared_preference.dart';
import 'package:pagination_amit_56/screens/home_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  void login(context) async {
    emit(LoginLoadingState());
    await DioHelper.postData(endPoint: "auth/login", data: {
      "phone": phoneController.text,
      "password": passwordController.text
    }).then((value) async {
      SharedPreferenceHelper.saveData(
          key: "token", value: value.data["access_token"]);
      SharedPreferenceHelper.saveData(
          key: "refreshToken", value: value.data["refresh_token"]);
      await DioHelper.initDioHelper();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginFailedState());
    });
  }
}
