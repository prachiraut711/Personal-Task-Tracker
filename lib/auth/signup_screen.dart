import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class SignupScreen extends StatelessWidget {
  final controller = Get.find<AuthController>(); // Use existing controller
  final email = TextEditingController();
  final password = TextEditingController();
  final RxBool isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: const Text(
                "Create your account",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 40),
            const Text("Email Address", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            TextField(
              controller: email,
              decoration: const InputDecoration(
                hintText: 'Email Address',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 15),
            const Text("Password", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 8),
            Obx(
              () => TextField(
                controller: password,
                obscureText: isPasswordHidden.value,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.white70,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.white70,
                    ),
                    onPressed: () => isPasswordHidden.toggle(),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF3D4A54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(
                      0xFFFDD471,
                    ), // Your yellow color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: controller.isLoading.value
                      ? null
                      : () async {
                          // Await the signup result
                          bool success = await controller.signup(
                            email.text.trim(),
                            password.text.trim(),
                          );

                          if (success) {
                            Get.snackbar(
                              "Account Created",
                              "Success! You can now log in.",
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.white,
                              colorText: Colors.black,
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.black,
                              ),
                              margin: const EdgeInsets.all(15),
                              duration: const Duration(seconds: 2),
                            );

                            // Wait a bit so they see the success message, then go back to login
                            Future.delayed(
                              const Duration(milliseconds: 1500),
                              () {
                                Get.offAllNamed('/login');
                              },
                            );
                          }
                        },
                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: GestureDetector(
                onTap: () => Get.back(), // Navigates back to the Login Screen
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Log In",
                        style: TextStyle(
                          color: const Color(
                            0xFFFDD471,
                          ), // Your yellow theme color
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
