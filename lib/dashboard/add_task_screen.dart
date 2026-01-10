import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';
import '../app/theme.dart';

class AddTaskScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  final controller = Get.put(TaskController());

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg, 
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Add New Task",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Get.back();
            } else {
              Get.offAllNamed('/dashboard'); 
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Task Title", style: TextStyle(color: AppColors.greyText)),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter title",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: AppColors.inputBg, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text("Description", style: TextStyle(color: AppColors.greyText)),
            const SizedBox(height: 8),
            TextField(
              controller: descController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter details",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: AppColors.inputBg, 
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryYellow, 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (titleController.text.trim().isNotEmpty) {
                            try {
                              await controller.addTask(
                                titleController.text.trim(),
                                descController.text.trim(),
                              );

                              Get.snackbar(
                                "Success",
                                "Task added successfully!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: Colors.black,
                                ),
                              );

                              await Future.delayed(
                                const Duration(milliseconds: 800),
                              );
                              Get.back();
                            } catch (e) {
                              Get.snackbar(
                                "Error",
                                "Failed to save task: $e",
                                backgroundColor: Colors.red,
                                colorText: Colors.white,
                              );
                            }
                          } else {
                            Get.snackbar(
                              "Warning",
                              "Please enter a task title",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.orange,
                              colorText: Colors.black,
                            );
                          }
                        },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          "Save Task",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}