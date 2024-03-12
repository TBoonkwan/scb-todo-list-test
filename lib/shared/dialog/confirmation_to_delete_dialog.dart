import 'package:flutter/material.dart';

class ConfirmationToDeleteDialog extends StatelessWidget {
  final Function(bool) onDialogClickListener;

  const ConfirmationToDeleteDialog({
    Key? key,
    required this.onDialogClickListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm Delete"),
      content: const Text("Are you sure you want to delete this task?"),
      actions: [
        TextButton(
          onPressed: () => onDialogClickListener.call(false),
          child: const Text("No"),
        ),
        TextButton(
          onPressed: () => onDialogClickListener.call(true),
          child: const Text("Yes, Delete"),
        ),
      ],
    );
  }
}
