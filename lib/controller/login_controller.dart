import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/auth/login_screen.dart';
import '../screens/home/home_screen.dart';
import '../utils/shared_pref_helper.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isVisible = RxBool(true);
  Rxn<User> firebaseUser = Rxn<User>();

   final FirebaseAuth auth;
  LoginController({FirebaseAuth? auth}) : auth = auth ?? FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    firebaseUser.bindStream(auth.authStateChanges());
  }

  void register(String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
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
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        if (value.user!.email!.isNotEmpty) {
          Get.snackbar("Login Success", "",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green);
          SharedPrefHelper.setBool("isLogin", true);
          Get.offAll(() => const HomeScreen());
        }
      });
    } catch (e) {
      Get.snackbar("Login Failed", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void logout() async {
    await auth.signOut();
    Get.snackbar("Signed Out Successfully", "",
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green);
    SharedPrefHelper.setBool("isLogin", false);
    Get.offAll(() => const LoginScreen());
  }
}
