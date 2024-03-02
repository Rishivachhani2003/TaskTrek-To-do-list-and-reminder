import 'package:flutter/material.dart';
import 'package:to_do_riverpod/widget/dialogs/generic_dialog.dart';

Future<bool> showDeleteAccountDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete Account',
    content: 'Are you sure you want to delete Account and all data?',
    optionsBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then((value) => value ?? false);
}
