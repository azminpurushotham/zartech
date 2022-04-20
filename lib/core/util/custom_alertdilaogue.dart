import 'package:flutter/material.dart';

class CustomAlertDialogue extends AlertDialog {
  String customTitle;
  String message;
  BuildContext context;
  Function? positiveAction, negativeAction;

  CustomAlertDialogue(
      {required this.context,
      required this.customTitle,
      required this.message,
      this.positiveAction,
      this.negativeAction});

  AlertDialog showDialogue() {
    return AlertDialog(
      title: Text(customTitle),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () => {Navigator.pop(context), negativeAction!()},
            child: Text('Cancel', style: TextStyle(color: Colors.blueAccent))),
        TextButton(
            onPressed: () => {Navigator.pop(context), positiveAction!()},
            child: Text('Ok', style: TextStyle(color: Colors.black)))
      ],
    );
  }
}
