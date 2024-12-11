import 'package:pagination_amit_56/features/auth/data/models/login_model.dart';
import 'package:pagination_amit_56/features/auth/data/web_services/web_services.dart';

class AuthRepository {
  final AutWebServices _autWebServices;

  AuthRepository(this._autWebServices);

  Future<LoginModel> login({required String phone, required String password}) async{
    return LoginModel.fromJson(await _autWebServices.login(phone: phone, password: password))  ; 
  }
}
