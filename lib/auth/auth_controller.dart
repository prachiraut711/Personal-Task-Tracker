import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var isLoading = false.obs;

  // Change 'void' to 'Future<bool>'
  Future<bool> login(String email, String password) async {
    // 1. Check for empty fields FIRST
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Required",
        "Please enter both email and password",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white,
        colorText: Colors.black,
      );
      return false;
    }

    try {
      isLoading(true);
      await _authService.login(email, password);
      return true;
    } catch (e) {
      // 2. Translate code messages into human text
      String errorMessage = "An error occurred. Please try again.";

      if (e.toString().contains('invalid-credential') ||
          e.toString().contains('Invalid login credentials')) {
        errorMessage = "Incorrect email or password.";
      } else if (e.toString().contains('network-request-failed')) {
        errorMessage = "No internet connection.";
      } else if (e.toString().contains('user-not-found')) {
        errorMessage = "No account found with this email.";
      }

      // 3. Show the clean snackbar for errors
      Get.snackbar(
        'Login Failed',
        errorMessage,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.white, // White background as requested
        colorText: Colors.black,
        icon: const Icon(Icons.error_outline, color: Colors.red),
        margin: const EdgeInsets.all(15),
      );

      return false;
    } finally {
      isLoading(false);
    }
  }

  Future<bool> signup(String email, String password) async {
    // 1. Check for empty fields
    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackbar("Required", "Please fill in all fields");
      return false;
    }

    // 2. Email Format Validation (Regex)
    bool isEmailValid = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    ).hasMatch(email);
    if (!isEmailValid) {
      _showErrorSnackbar(
        "Invalid Email",
        "Please enter a valid email address (e.g., name@gmail.com)",
      );
      return false;
    }

    // 3. Password Length Validation
    if (password.length < 6) {
      _showErrorSnackbar(
        "Weak Password",
        "Password must be at least 6 characters long",
      );
      return false;
    }

    try {
      isLoading(true);
      await _authService.signup(email, password);
      return true;
    } catch (e) {
      String errorMessage = "Could not create account.";
      if (e.toString().contains('already-registered') ||
          e.toString().contains('already in use')) {
        errorMessage = "This email is already registered.";
      }
      _showErrorSnackbar("Signup Failed", errorMessage);
      return false;
    } finally {
      isLoading(false);
    }
  }

  // Helper method to keep code clean
  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: Colors.black,
      icon: const Icon(Icons.error_outline, color: Colors.red),
      margin: const EdgeInsets.all(15),
    );
  }
}
