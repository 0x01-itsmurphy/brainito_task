import 'package:brainito_task/widgets/notes_card_widget.dart';
import 'package:flutter/material.dart';

import 'widgets/custom_textformfield.dart';
import 'widgets/note_form_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> notes = [];
  List<Map<String, String>> filteredNotes = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredNotes = notes;
  }

  void _filterNotes(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredNotes = notes;
      } else {
        filteredNotes = notes
            .where((note) =>
                (note["name"])!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brainito App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextField(
              controller: searchController,
              hintText: "Search items",
              prefixIcon: const Icon(Icons.search),
              onChanged: _filterNotes,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: filteredNotes.length,
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemBuilder: (context, index) {
                  final note = filteredNotes[index];
                  return NotesCardWidget(
                    name: note["name"]!,
                    onTap: () {
                      _showNoteDetail(context, note);
                    },
                    onDelete: () {
                      setState(() {
                        notes.removeAt(index);
                        _filterNotes(searchController.text);
                      });
                    },
                    onEdit: () {
                      _showNoteBottomSheet(
                        name: note["name"],
                        description: note["description"],
                        index: notes.indexOf(note),
                      );
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNoteBottomSheet();
        },
        child: const Icon(Icons.post_add_outlined),
      ),
    );
  }

  Future<dynamic> _showNoteDetail(
      BuildContext context, Map<String, String> note) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(note["name"]!),
          content: Text(note["description"]!),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  void _showNoteBottomSheet({String? name, String? description, int? index}) {
    final TextEditingController nameController =
        TextEditingController(text: name);
    final TextEditingController descriptionController =
        TextEditingController(text: description);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Form(
          key: formKey,
          child: NoteFormWidget(
            nameController: nameController,
            descriptionController: descriptionController,
            actionTitle: index == null ? "Add Note" : "Edit Note",
            onSave: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  if (index == null) {
                    notes.add({
                      "name": nameController.text,
                      "description": descriptionController.text,
                    });
                  } else {
                    notes[index] = {
                      "name": nameController.text,
                      "description": descriptionController.text,
                    };
                  }
                  _filterNotes(searchController.text);
                });
                Navigator.pop(context);
              }
            },
          ),
        );
      },
    );
  }
}
