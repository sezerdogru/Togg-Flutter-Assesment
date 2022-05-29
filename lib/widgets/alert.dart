import 'package:flutter/material.dart';

class Alert {
  static showAlertDialog(
    BuildContext context,
    String errMsg, {
    required String buttonText,
    required String errTitle,
  }) {
    // Create button
    Widget okButton = ElevatedButton(
      child: Text(buttonText),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(errTitle),
      content: Text(errMsg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
