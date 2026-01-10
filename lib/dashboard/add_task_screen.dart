import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';
import '../app/theme.dart';

class AddTaskScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();

  // Using Get.put to ensure the controller exists even if we navigate here directly
  final controller = Get.put(TaskController());

  AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E2630), // Dark Background
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Add New Task",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // --- FIXED BACK ARROW ---
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Get.back();
            } else {
              Get.offAllNamed('/dashboard'); // Fallback if history is lost
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Task Title", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter title",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF3D4A54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Description", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            TextField(
              controller: descController,
              maxLines: 4,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Enter details",
                hintStyle: const TextStyle(color: Colors.white38),
                filled: true,
                fillColor: const Color(0xFF3D4A54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),

            // --- FIXED SAVE BUTTON ---
            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFDD471), // Yellow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          if (titleController.text.trim().isNotEmpty) {
                            try {
                              // Call the controller method
                              await controller.addTask(
                                titleController.text.trim(),
                                descController.text.trim(),
                              );

                              // Success Message
                              Get.snackbar(
                                "Success",
                                "Task added successfully!",
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.white,
                                colorText: Colors.black,
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                ),
                              );

                              // Wait a moment for user to see success, then go back
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
                            fontWeight: FontWeight.normal,
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
