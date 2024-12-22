import 'package:flutter/material.dart';

class NotesCardWidget extends StatelessWidget {
  final String name;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const NotesCardWidget({
    super.key,
    required this.name,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      title: Text(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_forever_outlined,
              color: Colors.redAccent,
            ),
          ),
          IconButton(
            onPressed: onEdit,
            icon: const Icon(
              Icons.edit_note,
              color: Colors.green,
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
