import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/task_model.dart';

class HomeController extends GetxController {
  final FirebaseFirestore firestore;

  HomeController({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  final titleController = TextEditingController();
  final desController = TextEditingController();

  final isLoading = false.obs;
  final isSaving = false.obs;
  final tasks = <TaskModel>[].obs;

  late final taskRef = FirebaseFirestore.instance.collection('tasks');

  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  void fetchTasks() {
    isLoading.value = true;
    taskRef.snapshots().listen((snapshot) {
      tasks.value = snapshot.docs.map((doc) {
        return TaskModel.fromMap(doc.id, doc.data());
      }).toList();
      isLoading.value = false;
    });
  }

  Future<void> addTask() async {
    if (titleController.text.trim().isEmpty || desController.text.trim().isEmpty) return;

    isSaving.value = true;
    await taskRef.add({
      'title': titleController.text.trim(),
      'description': desController.text.trim(),
    });
    titleController.clear();
    desController.clear();
    isSaving.value = false;
    Get.back();
  }

  Future<void> deleteTask(String id) async {
    isLoading.value = true;
    await taskRef.doc(id).delete();
    isLoading.value = false;
  }

  Future<void> updateTask(String id) async {
    if (titleController.text.trim().isEmpty || desController.text.trim().isEmpty) return;

    isLoading.value = true;
    await taskRef.doc(id).update({
      'title': titleController.text.trim(),
      'description': desController.text.trim(),
    });
    titleController.clear();
    desController.clear();
    isLoading.value = false;
    Get.back();
  }

  void fillForm(TaskModel task) {
    titleController.text = task.title;
    desController.text = task.description;
  }
}
