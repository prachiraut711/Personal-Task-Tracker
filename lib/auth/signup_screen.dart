import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app/theme.dart';
import 'auth_controller.dart';

class SignupScreen extends StatelessWidget {
  final controller = Get.find<AuthController>(); 
  final email = TextEditingController();
  final password = TextEditingController();
  final RxBool isPasswordHidden = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg, 
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: SingleChildScrollView( 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80),
              const Center(
                child: Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              
              const Text("Email Address", style: TextStyle(color: AppColors.greyText)),
              const SizedBox(height: 8),
              TextField(
                controller: email,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Email Address',
                  hintStyle: const TextStyle(color: Colors.white38),
                  prefixIcon: const Icon(Icons.email_outlined, color: Colors.white70),
                  filled: true,
                  fillColor: AppColors.inputBg, 
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 15),
              const Text("Password", style: TextStyle(color: AppColors.greyText)),
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
                    fillColor: AppColors.inputBg, 
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
                      backgroundColor: AppColors.primaryYellow, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () async {
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
                                icon: const Icon(Icons.check_circle, color: Colors.black),
                                margin: const EdgeInsets.all(15),
                                duration: const Duration(seconds: 2),
                              );

                              Future.delayed(
                                const Duration(milliseconds: 1500),
                                () => Get.offAllNamed('/login'),
                              );
                            }
                          },
                    child: controller.isLoading.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2),
                          )
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
              
              const SizedBox(height: 20),
              
              Center(
                child: GestureDetector(
                  onTap: () => Get.back(), 
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Log In",
                          style: TextStyle(
                            color: AppColors.primaryYellow, 
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
      ),
    );
  }
}