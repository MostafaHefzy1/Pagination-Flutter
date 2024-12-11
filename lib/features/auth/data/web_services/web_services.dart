import 'package:pagination_amit_56/core/global/dio_helper.dart';
import 'package:pagination_amit_56/core/global/end_points.dart';

class AutWebServices {


  Future<dynamic> login(
      {required String phone, required String password}) async {
    var response = await DioHelper.postData(
        endPoint: loginEndPoint, data: {"phone": phone, "password": password});
    return response.data; 
  }


}
