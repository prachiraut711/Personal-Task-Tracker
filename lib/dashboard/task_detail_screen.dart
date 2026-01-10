import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/theme.dart';
import 'task_model.dart';
import 'task_controller.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  void _showEditDialog(TaskModel task, TaskController controller) {
    final titleEdit = TextEditingController(text: task.title);
    final descEdit = TextEditingController(text: task.description);

    Get.defaultDialog(
      backgroundColor: AppColors.darkBg, 
      title: "Edit Task",
      titleStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        children: [
          TextField(
            controller: titleEdit,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Title",
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: AppColors.inputBg, 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 15),

          TextField(
            controller: descEdit,
            style: const TextStyle(color: Colors.white),
            maxLines: 4,
            decoration: InputDecoration(
              hintText: "Description",
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: AppColors.inputBg, 
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      textConfirm: "Update",
      confirmTextColor: Colors.black,
      buttonColor: AppColors.primaryYellow, 
      onConfirm: () {
        controller.updateTask(task.id, titleEdit.text, descEdit.text);
        Get.back();
      },
      textCancel: "Cancel",
      cancelTextColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    final TaskModel initialTask = Get.arguments;
    final TaskController controller = Get.find<TaskController>();

    final titleController = TextEditingController(text: initialTask.title);
    final descController = TextEditingController(text: initialTask.description);

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text("Task Details", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: AppColors.primaryYellow),
            onPressed: () => _showEditDialog(initialTask, controller),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Obx(() {
          final task = controller.tasks.firstWhere(
            (t) => t.id == initialTask.id,
            orElse: () => initialTask,
          );

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, 
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: task.isCompleted
                        ? Colors.green.withOpacity(0.2)
                        : AppColors.primaryYellow.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    task.isCompleted ? "Completed" : "Ongoing",
                    style: TextStyle(
                      color: task.isCompleted
                          ? const Color(0xFF76F2B1) 
                          : AppColors.primaryYellow,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Task Title",
                style: TextStyle(color: AppColors.greyText, fontSize: 14),
              ),

              const SizedBox(height: 8),

              TextField(
                controller: titleController,
                readOnly: true,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.inputBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Description",
                style: TextStyle(color: AppColors.greyText, fontSize: 14),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: descController,
                readOnly: true,
                maxLines: 5,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.inputBg,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const Spacer(),

              SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: task.isCompleted
                        ? AppColors.inputBg
                        : AppColors.primaryYellow,
                    foregroundColor: task.isCompleted
                        ? Colors.white
                        : Colors.black,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: task.isCompleted
                        ? const BorderSide(color: Colors.white24)
                        : BorderSide.none,
                  ),
                  onPressed: () =>
                      controller.toggleTaskStatus(task.id, task.isCompleted),
                  child: Text(
                    task.isCompleted ? "Set as Ongoing" : "Mark as Completed",
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        }),
      ),
    );
  }
}