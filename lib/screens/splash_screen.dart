import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miles_assignment/screens/auth/login_screen.dart';
import 'package:miles_assignment/screens/home/home_screen.dart';
import 'package:miles_assignment/utils/shared_pref_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4)).then((value) {
      _getAuthDetails();
    });
    super.initState();
  }

  _getAuthDetails() async {
    bool? isLogin = await SharedPrefHelper.getBool("isLogin");
    if (isLogin == true) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
    );
  }
}
