import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../app/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Placeholder for the Figma Illustration
                  const Icon(Icons.task_alt, size: 100, color: AppColors.primaryYellow),
                  const SizedBox(height: 40),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Manage your Task with DayTask",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold, height: 1.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // Check if a user is already logged in
                final session = Supabase.instance.client.auth.currentSession;
                
                if (session != null) {
                  Get.offAllNamed('/dashboard'); 
                } else {
                  Get.offAllNamed('/login'); 
                }
              },
              child: const Text("Let's Start", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}