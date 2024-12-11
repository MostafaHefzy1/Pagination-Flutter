import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_amit_56/core/bloc_observer/bloc_observer.dart';
import 'package:pagination_amit_56/core/dio_helper.dart';
import 'package:pagination_amit_56/core/local/shared_preference.dart';
import 'package:pagination_amit_56/logic/auth/auth_cubit.dart';
import 'package:pagination_amit_56/logic/home/home_cubit.dart';
import 'package:pagination_amit_56/screens/home_screen.dart';
import 'package:pagination_amit_56/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferenceHelper.initSharedPreferenceHelper();
  await DioHelper.initDioHelper();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (BuildContext context) => AuthCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (BuildContext context) => HomeCubit()
            ..refreshToken()
            ..funPaginationListToDo(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SharedPreferenceHelper.getData(key: "token") != null
              ? HomeScreen()
              : LoginScreen()),
    );
  }
}
