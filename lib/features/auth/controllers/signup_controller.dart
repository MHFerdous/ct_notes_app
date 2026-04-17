import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct_notes_app/core/routes/app_router.dart';
import 'package:ct_notes_app/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final signupFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isPasswordHidden = true.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> signup() async {
    if (signupFormKey.currentState?.validate() ?? false) {
      try {
        isLoading.value = true;

        Get.dialog(
          const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor),
          ),
          barrierDismissible: false,
        );

        final authResult = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text,
            );

        if (authResult.user != null) {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(authResult.user!.uid)
              .set({
                'name': nameController.text.trim(),
                'email': emailController.text.trim(),
                'createdAt': FieldValue.serverTimestamp(),
              });

          Get.back();
          Get.snackbar(
            'Success',
            'Account created successfully!',
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          AppRouter.router.go(AppRouter.home);
        }
      } on FirebaseAuthException catch (e) {
        Get.back();
        debugPrint(e.toString());
        String message = 'An error occurred during signup';
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        }

        Get.snackbar(
          'Signup Failed',
          message,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.back();
        debugPrint(e.toString());
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
