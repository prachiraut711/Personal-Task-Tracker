import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_tracker/app/theme.dart';
import 'package:task_tracker/auth/signup_screen.dart';
import 'package:task_tracker/auth/splash_screen.dart';
import 'package:task_tracker/dashboard/add_task_screen.dart';
import 'package:task_tracker/dashboard/profile_screen.dart';
import 'package:task_tracker/dashboard/task_detail_screen.dart';
import 'auth/login_screen.dart';
import 'dashboard/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://kyfqwintrccqzzddfuji.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imt5ZnF3aW50cmNjcXp6ZGRmdWppIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjgwMTgwMTMsImV4cCI6MjA4MzU5NDAxM30.hPy3e70fgboFwPleJqvhejNC0iK2M4YpFkjIyoZBzec',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      // Change this to always start at Splash
      initialRoute: '/', 
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
        GetPage(name: '/dashboard', page: () => DashboardScreen()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
        GetPage(name: '/task-detail', page: () => const TaskDetailScreen()),
        GetPage(name: '/add-task', page: () => AddTaskScreen()),
      ],
    );
  }
}
