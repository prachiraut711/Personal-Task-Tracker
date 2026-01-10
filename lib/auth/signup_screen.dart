import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class SignupScreen extends StatelessWidget {
  final controller = Get.find<AuthController>(); // Use existing controller
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Create your account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 30),
            TextField(controller: email, decoration: const InputDecoration(hintText: 'Email Address', prefixIcon: Icon(Icons.email_outlined))),
            const SizedBox(height: 15),
            TextField(controller: password, obscureText: true, decoration: const InputDecoration(hintText: 'Password', prefixIcon: Icon(Icons.lock_outline))),
            const SizedBox(height: 30),
            Obx(() => ElevatedButton(
              onPressed: () => controller.signup(email.text, password.text),
              child: controller.isLoading.value ? const CircularProgressIndicator(color: Colors.black) : const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
            )),
            Center(
              child: TextButton(onPressed: () => Get.back(), child: const Text("Already have an account? Log In", style: TextStyle(color: Colors.white70))),
            )
          ],
        ),
      ),
    );
  }
}