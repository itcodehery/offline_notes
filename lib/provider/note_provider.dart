import 'package:flutter/material.dart';
import 'package:offline_notes/model/note_model.dart';
import 'package:offline_notes/storage/database_helper.dart';

class NotesProvider extends ChangeNotifier {
  final databaseHelper = DatabaseHelper();
  List<Note> _notes = [];

  List<Note> get notes => _notes;

  Future<void> getNotes() async {
    final db = await databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('Notes');
    _notes = List.generate(maps.length, (i) => Note.fromMap(maps[i]));
    notifyListeners();
  }

  Future<void> addNote(Note note) async {
    final db = await databaseHelper.database;
    final id = await db.insert('Notes', note.toMap());
    note.id = id; // Update the note object with generated id
    _notes.add(note);
    notifyListeners();
  }

  Future<void> updateNote(Note note) async {
    final db = await databaseHelper.database;
    await db.update(
      'Notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
    final index = _notes.indexWhere((element) => element.id == note.id);
    _notes[index] = note;
    notifyListeners();
  }

  Future<void> deleteNote(int id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'Notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    _notes.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
