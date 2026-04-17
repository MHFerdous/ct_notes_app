import 'package:ct_notes_app/features/notes/controllers/notes_controller.dart';
import 'package:ct_notes_app/features/notes/models/note_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNotesController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  bool addNote() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isNotEmpty && description.isNotEmpty) {
      final notesController = Get.find<NotesController>();
      notesController.notes.add(NoteModel(title: title, description: description));
      
      titleController.clear();
      descriptionController.clear();
      return true;
    } else {
      Get.snackbar(
        'Missing Fields',
        'Please enter a title and a description to save your note.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
