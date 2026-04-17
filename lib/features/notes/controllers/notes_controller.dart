import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ct_notes_app/core/routes/app_router.dart';
import 'package:ct_notes_app/core/theme/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ct_notes_app/features/notes/models/note_model.dart';
import 'dart:async';

class NotesController extends GetxController {
  final RxList<NoteModel> notes = <NoteModel>[].obs;
  final RxString userName = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription? _notesSubscription;

  @override
  void onInit() {
    super.onInit();
    _fetchUserName();
    _startListeningToNotes();
  }

  Future<void> _fetchUserName() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists && doc.data()?['name'] != null) {
          userName.value = doc.data()!['name'];
        }
      } catch (e) {
        debugPrint('Error fetching user name: $e');
      }
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      AppRouter.router.go(AppRouter.login);
      Get.snackbar(
        'Logged Out',
        'You have been successfully logged out.',
        backgroundColor: AppColors.primaryColor.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to logout: $e',
        backgroundColor: Colors.red.withValues(alpha: 0.7),
        colorText: Colors.white,
      );
    }
  }

  Future<void> refreshNotes() async {
    _notesSubscription?.cancel();
    _startListeningToNotes();
    await Future.delayed(const Duration(milliseconds: 800));
  }

  void _startListeningToNotes() {
    final user = _auth.currentUser;
    if (user != null) {
      _notesSubscription = _firestore
          .collection('notes')
          .where('userId', isEqualTo: user.uid)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
            notes.value = snapshot.docs
                .map((doc) => NoteModel.fromMap(doc.id, doc.data()))
                .toList();
          });
    }
  }

  @override
  void onClose() {
    _notesSubscription?.cancel();
    super.onClose();
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
