import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task_controller.dart';
import 'task_tile.dart';
import '../app/theme.dart';

class DashboardScreen extends StatelessWidget {
  // Use Get.find if the controller is already initialized in main/bindings
  // or Get.put if this is the first time.
  final controller = Get.put(TaskController());
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();

  DashboardScreen({super.key});

  // Method to show the Figma-style Bottom Sheet
  void _showAddTaskSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
          left: 20,
          right: 20,
        ),
        decoration: const BoxDecoration(
          color: AppColors.inputBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: SizedBox(
                width: 50,
                child: Divider(thickness: 4, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Create New Task",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            const Text("Task Title", style: TextStyle(color: AppColors.greyText)),
            const SizedBox(height: 8),
            TextField(
              controller: taskTitleController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(hintText: "e.g. Design UI Wireframe"),
            ),
            const SizedBox(height: 15),
            const Text("Description", style: TextStyle(color: AppColors.greyText)),
            const SizedBox(height: 8),
            TextField(
              controller: taskDescController,
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
              decoration: const InputDecoration(hintText: "Enter task details..."),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (taskTitleController.text.isNotEmpty) {
                  controller.addTask(
                    taskTitleController.text, 
                    taskDescController.text
                  );
                  taskTitleController.clear();
                  taskDescController.clear();
                  Get.back();
                }
              },
              child: const Text("Create Task", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 12, color: AppColors.primaryYellow),
            ),
            Text(
              Supabase.instance.client.auth.currentUser?.email?.split('@')[0] ?? "User",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: AppColors.primaryYellow,
                child: Icon(Icons.person, color: Colors.black, size: 20),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Your Tasks",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primaryYellow));
                }
                if (controller.tasks.isEmpty) {
                  return const Center(
                    child: Text("No tasks found", style: TextStyle(color: AppColors.greyText)),
                  );
                }
                return ListView.builder(
                  itemCount: controller.tasks.length,
                  itemBuilder: (context, index) {
                    final task = controller.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: GestureDetector(
                        onTap: () => Get.toNamed('/task-detail', arguments: task),
                        child: TaskTile(
                          title: task.title,
                          onDelete: () => controller.deleteTask(task.id),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.inputBg,
        selectedItemColor: AppColors.primaryYellow,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: "Add"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: "Calendar"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none_outlined), label: "Notifs"),
        ],
        onTap: (index) {
          if (index == 2) {
            _showAddTaskSheet(context);
          } else if (index == 4) {
            // Optional: Quick link to profile from notifications if you want
            Get.toNamed('/profile');
          }
        },
      ),
    );
  }
}