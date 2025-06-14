import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miles_assignment/controller/login_controller.dart';

import '../../controller/home_controller.dart';
import '../../utils/global_utility.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  LoginController loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,bottom: true,
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text(
            "Home",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  loginController.logout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        body: Obx(() {
          if (homeController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (homeController.tasks.isEmpty) {
            return  Center(child: Text("No Tasks Found",style: Theme.of(context).textTheme.titleMedium,));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemBuilder: (context, index) {
              final task = homeController.tasks[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        child: const Icon(Icons.edit, color: Colors.orange),
                        onTap: () {
                          _showBottomSheet(context,
                              isEdit: true, taskId: task.id);
                          homeController.fillForm(task);
                        },
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        child: const Icon(Icons.delete, color: Colors.red),
                        onTap: () =>
                            homeController.deleteTask(task.id).then((value) {
                          setState(() {
                            homeController.fillForm(task);
                          });
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemCount: homeController.tasks.length,
          );
        }),
        floatingActionButton: GestureDetector(
          onTap: () {
            _showBottomSheet(context);
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.blueAccent,
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(1, 1.2),
                      blurRadius: 3,
                      spreadRadius: 1,
                      color: Colors.black12),
                ]),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context,
      {bool isEdit = false, String? taskId}) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: homeController.titleController,
                    decoration: customInputDecoration(
                        label: "Title", hint: "Enter title", context: context),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: homeController.desController,
                    decoration: customInputDecoration(
                        label: "Description",
                        hint: "Enter description",
                        context: context),
                  ),
                  const SizedBox(height: 16),
                  homeController.isSaving.value
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor),
                          onPressed: () {
                            if (isEdit && taskId != null) {
                              homeController.updateTask(taskId);
                            } else {
                              homeController.addTask();
                            }
                            homeController.titleController.clear();
                            homeController.desController.clear();
                          },
                          child: Text(
                            isEdit ? "Update" : "Save",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                ],
              )),
        );
      },
    );
  }
}
