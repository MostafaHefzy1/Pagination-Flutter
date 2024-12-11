import 'package:dio/dio.dart';
import 'package:pagination_amit_56/core/local/shared_preference.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioHelper {
  static Dio? dio;

  static initDioHelper() {
    dio = Dio(BaseOptions(
      baseUrl: "https://todo.iraqsapp.com/",
      receiveDataWhenStatusError: true,
      headers: {
         "Authorization": 'Bearer ${SharedPreferenceHelper.getData(key: "token")}',
      }
    ));

    // customization
    dio!.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
    ));
  }

  static Future<Response> getData(
      {required String endPoint, Map<String, dynamic>? queryParameters}) async {
    return await dio!.get(endPoint, queryParameters: queryParameters);
  }

  static Future<Response> postData(
      {required String endPoint, required dynamic data}) async {
    return await dio!.post(endPoint, data: data);
  }
}
