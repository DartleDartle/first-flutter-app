import 'package:firstapp/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/material.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: 'Sharing Error',
    content: 'Please add some content to the note before sharing it.',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
