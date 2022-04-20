import 'package:flutter/material.dart';

class CustomAlertDialogue extends AlertDialog {
  String customTitle;
  String message;
  BuildContext context;
  Function? positiveAction, negativeAction;
  dynamic? position, item;

  CustomAlertDialogue(
      {required this.context,
      required this.customTitle,
      required this.message,
      this.positiveAction,
      this.negativeAction,
      dynamic? this.position,
      dynamic? this.item});

  AlertDialog showDialogue() {
    return AlertDialog(
      title: Text(customTitle),
      content: Text(message),
      actions: [
        FloatingActionButton(
            onPressed: () => {
                  Navigator.pop(context),
                  negativeAction!(this.position, this.item)
                },
            child: Text('Cancel')),
        FloatingActionButton(
            onPressed: () => {
                  Navigator.pop(context),
                  positiveAction!(this.position, this.item)
                },
            child: Text('Ok'))
      ],
    );
  }
}
