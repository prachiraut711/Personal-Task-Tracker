import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';
import '../dashboard/dashboard_screen.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(AuthController());
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: email, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: password, decoration: InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            Obx(() => ElevatedButton(
              onPressed: () {
                controller.login(email.text, password.text);
              },
              child: controller.isLoading.value
                  ? CircularProgressIndicator()
                  : Text('Login'),
            )),
            TextButton(
              onPressed: () => Get.toNamed('/signup'),
              child: Text('Create Account'),
            )
          ],
        ),
      ),
    );
  }
}
