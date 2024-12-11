import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_amit_56/features/auth/logic/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        var cubit = AuthCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurple,
            title: const Text(
              "Login Screen",
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: cubit.phoneController,
                    validator: (value) {
                      print("value $value");
                      if (value!.isEmpty) {
                        return "error";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: "Emails",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: cubit.passwordController,
                    decoration: InputDecoration(
                        hintText: "Pass",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  TextButton(
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.login(context);
                        }
                      },
                      child: const Text("data"))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
