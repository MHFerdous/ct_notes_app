import 'package:ct_notes_app/core/routes/app_router.dart';
import 'package:ct_notes_app/core/theme/app_colors.dart';
import 'package:ct_notes_app/core/widgets/custom_elevated_button.dart';
import 'package:ct_notes_app/core/widgets/custom_text_form_field.dart';
import 'package:ct_notes_app/features/notes/controllers/add_notes_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddNoteScreen extends StatelessWidget {
  const AddNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddNotesController());

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F7F4),
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            controller.titleController.clear();
            controller.descriptionController.clear();
            if (AppRouter.router.canPop()) {
              AppRouter.router.pop();
            } else {
              AppRouter.router.go(AppRouter.home);
            }
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF0EFEC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF1A1A2E),
              size: 18,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                'New Note',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1A1A2E),
                  letterSpacing: -1.0,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Write your thoughts below.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: AppColors.backgroundColor,
                ),
              ),
              const SizedBox(height: 36),
              CustomTextFormField(
                controller: controller.titleController,
                labelText: 'Title',
                prefixIcon: Icons.title_rounded,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: controller.descriptionController,
                labelText: 'Description',
                prefixIcon: Icons.notes_rounded,
                maxLines: 5,
              ),
              const SizedBox(height: 40),
              Obx(
                () => CustomElevatedButton(
                  text: controller.isLoading.value ? 'Saving...' : 'Save Note',
                  onPressed: controller.isLoading.value
                      ? () {}
                      : () async {
                          if (await controller.addNote()) {
                            if (AppRouter.router.canPop()) {
                              AppRouter.router.pop();
                            } else {
                              AppRouter.router.go(AppRouter.home);
                            }
                          }
                        },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
