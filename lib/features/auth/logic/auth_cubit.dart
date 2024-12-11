import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_amit_56/core/global/dio_helper.dart';
import 'package:pagination_amit_56/core/local/shared_preference.dart';
import 'package:pagination_amit_56/core/services/services_locator.dart';
import 'package:pagination_amit_56/features/auth/data/repository/repository.dart';
import 'package:pagination_amit_56/screens/home_screen.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  // SharedPreferenceHelper _preferenceHelper  = sl<SharedPreferenceHelper>();
  void login(context) async {
    emit(LoginLoadingState());
    await _authRepository
        .login(phone: phoneController.text, password: passwordController.text)
        .then((value) async {
      sl<SharedPreferenceHelper>().saveData(key: "token", value: value.accessToken);
      sl<SharedPreferenceHelper>().saveData(
          key: "refreshToken", value: value.refreshToken);


        
      await DioHelper.initDioHelper();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      emit(LoginSuccessState());
    }).catchError((error) {
      emit(LoginFailedState());
    });
  }
}
