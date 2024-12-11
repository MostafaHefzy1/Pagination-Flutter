import 'package:get_it/get_it.dart';
import 'package:pagination_amit_56/core/local/shared_preference.dart';
import 'package:pagination_amit_56/features/auth/data/repository/repository.dart';
import 'package:pagination_amit_56/features/auth/data/web_services/web_services.dart';
import 'package:pagination_amit_56/features/auth/logic/auth_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> initGetIt() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(sharedPreferences));



  // Auth
  sl.registerFactory(() => AuthCubit(sl()));
  sl.registerLazySingleton(() => AuthRepository(sl()));
  sl.registerLazySingleton(() => AutWebServices());
}
