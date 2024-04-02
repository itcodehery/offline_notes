import 'package:flutter/material.dart';
import 'package:offline_notes/model/note_model.dart';
import 'package:offline_notes/provider/note_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void showAddNoteSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Consumer<NotesProvider>(
          builder: (context, value, child) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Add Note'),
                const TextField(
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                const SizedBox(height: 16),
                TextField(
                  maxLines: 8, //or null
                  decoration: InputDecoration(
                      hintText: "Enter your text here",
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    value.addNote(
                      Note(
                        title: 'Title',
                        content: 'Content',
                        timestamp: DateTime.now(),
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Add Note'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NotesProvider>(
      builder: (context, value, child) => Scaffold(
        body: Center(
            child: ListView.builder(
          itemBuilder: (context, index) {
            var note = value.notes[index];
            return ListTile(
              title: Text(note.title),
              subtitle: Text(note.content),
            );
          },
          itemCount: value.notes.length,
        )),
        bottomNavigationBar: BottomAppBar(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: null,
            ),
            const Spacer(),
            const IconButton(
              icon: Icon(Icons.search),
              onPressed: null,
            ),
            const IconButton(
              icon: Icon(Icons.settings_outlined),
              onPressed: null,
            ),
            ElevatedButton(
                onPressed: showAddNoteSheet, child: const Icon(Icons.add)),
          ],
        )),
      ),
    );
  }
}
