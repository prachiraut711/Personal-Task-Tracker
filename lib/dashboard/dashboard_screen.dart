import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task_controller.dart';
import 'task_tile.dart';
import '../app/theme.dart';

class DashboardScreen extends StatelessWidget {
  final controller = Get.put(TaskController());
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg, 
      appBar: AppBar(
        backgroundColor: AppColors.darkBg,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 12, color: AppColors.primaryYellow),
            ),
            const SizedBox(height: 8),
            Text(
              Supabase.instance.client.auth.currentUser?.email?.split('@')[0] ?? "User",
              style: const TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
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
                child: Icon(Icons.person, color: AppColors.darkBg, size: 20),
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
            const SizedBox(height: 50),
            const Text(
              "Your Tasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryYellow,
                    ),
                  );
                }
                if (controller.tasks.isEmpty) {
                  return const Center(
                    child: Text(
                      "No tasks found",
                      style: TextStyle(color: AppColors.greyText),
                    ),
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
        backgroundColor: AppColors.darkBg, 
        selectedItemColor: AppColors.primaryYellow,
        unselectedItemColor: AppColors.greyText,
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
            Get.toNamed('/add-task');
          } else if (index == 4) {
            Get.toNamed('/profile');
          }
        },
      ),
    );
  }
}