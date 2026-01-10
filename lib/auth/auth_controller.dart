import 'package:get/get.dart';
import 'auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  var isLoading = false.obs;

  void login(String email, String password) async {
    try {
      isLoading(true);
      await _authService.login(email, password);
      Get.offAllNamed('/dashboard');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void signup(String email, String password) async {
    try {
      isLoading(true);
      await _authService.signup(email, password);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
