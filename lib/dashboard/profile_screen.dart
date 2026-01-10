import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/theme.dart';
import 'task_controller.dart'; // Import the controller

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;
    // Find the existing TaskController instance
    final taskController = Get.find<TaskController>();

    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // 1. Profile Image & Name
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primaryYellow,
              child: Icon(Icons.person, size: 50, color: Colors.black),
            ),
            const SizedBox(height: 15),
            Text(
              user?.email?.split('@')[0].toUpperCase() ?? "USER NAME",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              user?.email ?? "email@example.com",
              style: const TextStyle(color: AppColors.greyText),
            ),
            const SizedBox(height: 30),

            // 2. Dynamic Stats Grid (Ongoing vs Completed)
            // We use Obx here so the counts update automatically
            Obx(
              () => Row(
                children: [
                  _buildStatCard(
                    taskController.ongoingCount.toString(),
                    "Ongoing",
                    AppColors.primaryYellow,
                  ),
                  const SizedBox(width: 15),
                  _buildStatCard(
                    taskController.completedCount.toString(),
                    "Completed",
                    Colors.greenAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 3. Settings List
            _buildProfileOption(Icons.notifications_none, "Notifications"),
            _buildProfileOption(Icons.security, "Security"),
            _buildProfileOption(Icons.help_outline, "Help & Support"),
            _buildProfileOption(Icons.people_outline, "Invite Friends"),

            const SizedBox(height: 20),

            // 4. Logout Button
            ListTile(
              onTap: () async {
                await Supabase.instance.client.auth.signOut();
                Get.offAllNamed('/login');
              },
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                "Log Out",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper for the Stats Cards
  Widget _buildStatCard(String count, String label, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.inputBg,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Text(
              count,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 5),
            Text(label, style: const TextStyle(color: AppColors.greyText)),
          ],
        ),
      ),
    );
  }

  // Helper for the Settings Options
  Widget _buildProfileOption(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.inputBg.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.greyText,
        ),
        onTap: () {
          Get.snackbar("Info", "$title feature coming soon!");
        },
      ),
    );
  }
}
