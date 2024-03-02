import 'package:flutter/material.dart';
import 'package:to_do_riverpod/widget/dialogs/generic_dialog.dart';

Future<bool> showDeleteNoteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete Task',
    content: 'Are you sure you want to delete?',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then((value) => value ?? false);
}
