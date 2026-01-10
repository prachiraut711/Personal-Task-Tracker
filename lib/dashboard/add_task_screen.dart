import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';
import '../app/theme.dart';

class AddTaskScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final controller = Get.find<TaskController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(title: const Text("Add New Task"), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(hintText: "Title")),
            const SizedBox(height: 15),
            TextField(controller: descController, maxLines: 3, decoration: const InputDecoration(hintText: "Description")),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                controller.addTask(titleController.text, descController.text);
                Get.back();
              },
              child: const Text("Save Task"),
            )
          ],
        ),
      ),
    );
  }
}