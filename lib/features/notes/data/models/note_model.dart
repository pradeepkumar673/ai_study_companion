// lib/features/notes/data/models/note_model.dart
import 'package:isar/isar.dart';
part 'note_model.g.dart';

enum NoteColor { none, red, orange, yellow, green, blue, purple, pink }

@collection
class NoteModel {
  Id id = Isar.autoIncrement;
  @Index(unique: true) late String uuid;
  @Index(type: IndexType.value) late String title;
  String content = '';
  String? subject;
  @enumerated NoteColor color = NoteColor.none;
  List<String> tags = [];
  bool isPinned = false;
  bool isArchived = false;
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  // AI-generated summary (HuggingFace facebook/bart-large-cnn)
  // TODO: String? aiSummary;
  // AI-generated quiz questions from note content
  // TODO: List<String>? aiQuizQuestions;
}
