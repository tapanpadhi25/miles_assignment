import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miles_assignment/screens/auth/login_screen.dart';
import 'package:get/get.dart';

import 'package:miles_assignment/controller/login_controller.dart';

// Replace controller’s FirebaseAuth with the mock in your test
void main() {
  late MockFirebaseAuth mockAuth;

  setUpAll(() async {
    await  Firebase.initializeApp();
    // Firebase mock setup
    mockAuth = MockFirebaseAuth();

    // Override the LoginController with mocked FirebaseAuth
    Get.put(LoginController(auth: mockAuth)); // Modify controller to accept auth
  });

  testWidgets('Login screen should validate and navigate', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginScreen(),
        getPages: [
          GetPage(name: '/home', page: () => const Scaffold(body: Text('Home'))),
        ],
      ),
    );

    final emailField = find.byKey(Key('emailField'));
    final passwordField = find.byKey(Key('passwordField'));
    final loginButton = find.byKey(Key('loginButton'));

    await tester.enterText(emailField, 'tapank@gmail.com');
    await tester.enterText(passwordField, '123456');
    await tester.tap(loginButton);

    await tester.pump();
    await tester.pump(Duration(seconds: 1));
    expect(find.text('Home'), findsOneWidget);
  });
}
