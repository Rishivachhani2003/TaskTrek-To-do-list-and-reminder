import 'package:flutter/material.dart';
import 'package:to_do_riverpod/widget/dialogs/generic_dialog.dart';

Future<bool> showLogOutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'SignOut',
    content: 'Are you sure you want to SignOut?',
    optionsBuilder: () => {
      'Cancel': false,
      'SignOut': true,
    },
  ).then((value) => value ?? false);
}
