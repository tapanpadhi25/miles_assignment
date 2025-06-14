import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miles_assignment/screens/auth/login_screen.dart';
import 'package:miles_assignment/utils/shared_pref_helper.dart';

import '../screens/home/home_screen.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isVisible = RxBool(true);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  // }======tapank@gmail.com===123456
  void register(String email, String password) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      Future.delayed(const Duration(milliseconds: 10), () {
        Get.snackbar(
          "Success",
          "User created successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );

      });
      Get.back();
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }


  void login(String email, String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user!.email!.isNotEmpty) {
          Get.snackbar("Login Success", "",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green);
          SharedPrefHelper.setBool("isLogin", true);
          Get.offAll(() => const HomeScreen());
        }
        print("Login ===== $value");
      });
    } catch (e) {
      Get.snackbar("Login Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logout() async {
    await _auth.signOut();
    Get.snackbar("Signed Out Successfully", "",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    SharedPrefHelper.setBool("isLogin", false);
    Get.offAll(() => const LoginScreen());
  }
}
