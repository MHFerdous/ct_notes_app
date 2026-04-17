import 'package:ct_notes_app/core/routes/app_router.dart';
import 'package:ct_notes_app/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    if (loginFormKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;

        Get.dialog(
          const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          barrierDismissible: false,
        );

        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );

        Get.back();
        Get.snackbar(
          'Success',
          'Logged in successfully!',
          backgroundColor: AppColors.primaryColor,
          colorText: Colors.white,
        );
        AppRouter.router.go(AppRouter.home);
      } on FirebaseAuthException catch (e) {
        Get.back();

        String message = 'An error occurred during sign in.';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else if (e.code == 'invalid-credential') {
          message = 'Invalid email or password.';
        } else if (e.code == 'user-disabled') {
          message = 'This user account has been disabled.';
        }

        Get.snackbar(
          'Login Failed',
          message,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.back();
        Get.snackbar(
          'Error',
          e.toString(),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
