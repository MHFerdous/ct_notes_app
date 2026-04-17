import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String userId;
  final String title;
  final String description;
  final DateTime? createdAt;

  NoteModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
    };
  }

  factory NoteModel.fromMap(String id, Map<String, dynamic> map) {
    return NoteModel(
      id: id,
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
