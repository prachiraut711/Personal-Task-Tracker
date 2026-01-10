import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(AuthController());
  final email = TextEditingController();
  final password = TextEditingController();

  // Observable for password visibility toggle
  final RxBool isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFF1E2630,
      ), // Matching the dark theme in image
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
            children: [
              const SizedBox(height: 120),
              // --- Welcome Text ---
              Center(
                child: const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // --- Email Field ---
              const Text("Email Address", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              TextField(
                controller: email,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.white70,
                  ),
                  hintText: "fazzil72@gmail.com",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0xFF3D4A54),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Password Field ---
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

              // Forgot Password link
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // --- Login Button ---
              Obx(
                () => SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFDD471),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    // Use async here to allow awaiting the controller response
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
                            // Await the boolean result from the controller
                            bool success = await controller.login(
                              email.text,
                              password.text,
                            );

                            if (success) {
                              // Show the white success snackbar
                              Get.snackbar(
                                "Login Successful",
                                "Welcome back to your dashboard!",
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

                              // Delay navigation slightly so user sees the snackbar
                              Future.delayed(
                                const Duration(milliseconds: 1500),
                                () {
                                  Get.offAllNamed('/dashboard');
                                },
                              );
                            }
                          },
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.black,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Log In',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),

              // --- Sign Up Footer ---
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed('/signup'),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFFFDD471),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
