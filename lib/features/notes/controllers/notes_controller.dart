import 'package:get/get.dart';
import 'package:ct_notes_app/features/notes/models/note_model.dart';

class NotesController extends GetxController {
  final RxList<NoteModel> notes = <NoteModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDemoNotes();
  }

  void _loadDemoNotes() {
    notes.assignAll([
      NoteModel(
        title: 'Grocery List',
        description: 'Milk, Eggs, Bread, Butter',
      ),
      NoteModel(
        title: 'Meeting Notes',
        description:
            'Discuss project timeline and milestones. Make sure to review the MVP features.',
      ),
      NoteModel(
        title: 'Ideas',
        description: 'App features: dark mode, sync, tags, markdown support.',
      ),
    ]);
  }

  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }
}
