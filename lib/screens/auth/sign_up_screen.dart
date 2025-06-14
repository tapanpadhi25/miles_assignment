import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miles_assignment/controller/login_controller.dart';

import '../../utils/global_utility.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController= TextEditingController();
  RxBool isVisible = RxBool(true);
  LoginController loginController = Get.find();
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
                Text("Sign Up", style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 16),
                TextFormField(
                  autofocus: false,
                  controller: emailController,
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
                  obscureText: isVisible.value,
                  controller: passwordController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Password";
                    }else if(value.length <6){
                      return "Password must be 6 digits or more";
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
                            isVisible.value =
                            !isVisible.value;
                          });
                        },
                        child: Icon(isVisible.value
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
                        loginController.register(emailController.text.trim(), passwordController.text);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 12),
                      child: Text(
                        "SignUp",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    )),

              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    emailController.clear();
    passwordController.clear();
    super.dispose();
  }
}
