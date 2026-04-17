import 'package:ct_notes_app/core/routes/app_router.dart';
import 'package:ct_notes_app/core/widgets/custom_elevated_button.dart';
import 'package:ct_notes_app/core/widgets/custom_text_form_field.dart';
import 'package:ct_notes_app/features/auth/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (AppRouter.router.canPop()) {
              AppRouter.router.pop();
            } else {
              AppRouter.router.go(AppRouter.login);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: controller.signupFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Sign up to get started!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextFormField(
                  controller: controller.nameController,
                  labelText: 'Full Name',
                  prefixIcon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your full name';
                    } else if (value.length < 3) {
                      return 'Name must be at least 3 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: controller.emailController,
                  labelText: 'Email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!GetUtils.isEmail(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Obx(
                  () => CustomTextFormField(
                    controller: controller.passwordController,
                    labelText: 'Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: controller.isPasswordHidden.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 40),
                CustomElevatedButton(
                  text: 'Sign Up',
                  onPressed: controller.signup,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: GoogleFonts.poppins(color: Colors.grey.shade700),
                    ),
                    TextButton(
                      onPressed: () {
                        AppRouter.router.go(AppRouter.login);
                      },
                      child: Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          color: Colors.blue.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
