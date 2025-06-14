import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:miles_assignment/controller/home_controller.dart';
import 'package:miles_assignment/screens/home/home_screen.dart';

void main() {
  testWidgets('HomeScreen shows task list from fake firestore', (WidgetTester tester) async {
    final fakeFirestore = FakeFirebaseFirestore();

    // Add fake task to the collection
    await fakeFirestore.collection('tasks').add({
      'title': 'Test Task',
      'description': 'This is a test task',
    });

    // Inject fake controller
    Get.put(HomeController(firestore: fakeFirestore));

    await tester.pumpWidget(
      GetMaterialApp(
        home: const HomeScreen(),
      ),
    );

    // Wait for stream and UI
    await tester.pump(); // first build
    await tester.pump(const Duration(milliseconds: 100)); // wait for Firestore listener

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('This is a test task'), findsOneWidget);
  });
}
