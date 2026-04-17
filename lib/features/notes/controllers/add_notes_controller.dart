import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ct_notes_app/features/notes/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotesController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final isLoading = false.obs;

  Future<bool> addNote() async {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      Get.snackbar(
        'Missing Fields',
        'Please enter a title and a description to save your note.',
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
      return false;
    }

    try {
      isLoading.value = true;
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Get.snackbar('Error', 'User not logged in');
        return false;
      }

      final note = NoteModel(
        userId: user.uid,
        title: title,
        description: description,
      );

      await FirebaseFirestore.instance.collection('notes').add(note.toMap());

      titleController.clear();
      descriptionController.clear();

      Get.snackbar(
        'Success',
        'Note saved successfully!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save note: $e',
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
