import 'package:flutter/material.dart';

import 'custom_textformfield.dart';

class NoteFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final VoidCallback onSave;
  final String actionTitle;

  const NoteFormWidget({
    super.key,
    required this.nameController,
    required this.descriptionController,
    required this.onSave,
    required this.actionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            actionTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          CustomTextField(
            controller: nameController,
            hintText: "Enter name",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name is required";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: descriptionController,
            hintText: "Enter description",
            maxLines: 3,
          ),
          const SizedBox(height: 50),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSave,
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
