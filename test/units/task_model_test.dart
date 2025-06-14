// test/unit/task_model_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:miles_assignment/model/task_model.dart';

void main() {
  test('TaskModel serialization works', () {
    final task = TaskModel(id: '1', title: 'Test', description: 'Test desc');
    final map = task.toMap();
    final fromMap = TaskModel.fromMap('1', map);

    expect(fromMap.id, '1');
    expect(fromMap.title, 'Test');
    expect(fromMap.description, 'Test desc');
  });
}
