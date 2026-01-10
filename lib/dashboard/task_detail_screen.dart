import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/theme.dart';
import 'task_model.dart';
import 'task_controller.dart'; // Import controller

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  void _showEditDialog(TaskModel task) {
    final editController = TextEditingController(text: task.title);
    final TaskController taskController = Get.find<TaskController>();

    Get.defaultDialog(
      backgroundColor: AppColors.inputBg,
      title: "Edit Task",
      titleStyle: const TextStyle(color: Colors.white),
      content: TextField(
        controller: editController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(hintText: "Enter new title"),
      ),
      textConfirm: "Update",
      confirmTextColor: Colors.black,
      onConfirm: () {
        taskController.updateTask(task.id, editController.text);
        Get.back(); // Close dialog
        Get.back(); // Return to Dashboard to see refreshed list
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final TaskModel task = Get.arguments;

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Task Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primaryYellow),
            onPressed: () => _showEditDialog(task),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Task Title", style: TextStyle(color: AppColors.greyText)),
            const SizedBox(height: 10),
            Obx(() {
               // We find the task in the controller to ensure UI updates if edited
               final TaskController c = Get.find<TaskController>();
               final currentTask = c.tasks.firstWhere((t) => t.id == task.id, orElse: () => task);
               return Text(
                currentTask.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              );
            }),
            const SizedBox(height: 20),
            const Text("Status", style: TextStyle(color: AppColors.greyText)),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryYellow.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text("Ongoing", style: TextStyle(color: AppColors.primaryYellow)),
            ),
          ],
        ),
      ),
    );
  }
}