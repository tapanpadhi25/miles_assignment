import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miles_assignment/controller/login_controller.dart';
import 'package:miles_assignment/screens/auth/sign_up_screen.dart';
import 'package:miles_assignment/screens/home/home_screen.dart';

import '../../utils/global_utility.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  LoginController loginController = Get.put(LoginController());
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Obx(() {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Login", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                TextFormField(
                  autofocus: false,
                  controller: loginController.emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter Email Id";
                    }
                    return null;
                  },
                  decoration: customInputDecoration(
                      label: "Email Id", hint: "Email Id", context: context),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  autofocus: false,
                  obscureText: loginController.isVisible.value,
                  controller: loginController.passwordController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Password";
                    }
                    return null;
                  },
                  decoration: customInputDecoration(
                      label: "Password",
                      hint: "Password",
                      context: context,
                      suffixIcon: InkWell(
                        focusColor: Colors.transparent,
                        onTap: () {
                          setState(() {
                            loginController.isVisible.value =
                            !loginController.isVisible.value;
                          });
                        },
                        child: Icon(loginController.isVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: () {
                      if(_key.currentState!.validate()){
                        print("======${loginController.emailController.text}===${loginController.passwordController.text}");
                        loginController.login(loginController.emailController.text.trim(), loginController.passwordController.text);

                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Text(
                        "Login",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    )),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const SignUpScreen());
                  },
                  child: Text.rich(TextSpan(children: [
                    TextSpan(
                        text: "New User?  ",
                        style: Theme.of(context).textTheme.titleSmall),
                    TextSpan(
                        text: "Sign Up",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.blueAccent)),
                  ])),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    loginController.emailController.clear();
    loginController.passwordController.clear();
    super.dispose();
  }
}
