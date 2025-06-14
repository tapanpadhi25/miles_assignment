import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:miles_assignment/screens/auth/login_screen.dart';
import 'package:miles_assignment/controller/login_controller.dart';

void main() {
  setUpAll(() async {
    // Initializes Flutter bindings and Firebase
    TestWidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    Get.put(LoginController()); // Inject the controller
  });

  testWidgets('Login screen renders and validates inputs', (WidgetTester tester) async {
    // Build the LoginScreen inside GetMaterialApp
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginScreen(),
        getPages: [
          GetPage(name: '/home', page: () => const Scaffold(body: Text('Home'))),
        ],
      ),
    );

    // Find fields using Key (you must assign them in your LoginScreen widget)
    final emailField = find.byKey(const Key('emailField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.byKey(const Key('loginButton'));

    // Enter test input
    await tester.enterText(emailField, 'tapank@gmail.com');
    await tester.enterText(passwordField, '123456');
    await tester.tap(loginButton);

    // Wait for loading + potential navigation
    await tester.pump(); // shows loading
    await tester.pump(const Duration(seconds: 2)); // simulate async login delay

    // Expect home screen to appear
    expect(find.text('Home'), findsOneWidget);
  });
}
