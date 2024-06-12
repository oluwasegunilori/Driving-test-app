import 'package:flutter/material.dart';

ElevatedButton primaryButton(
    {required BuildContext context,
    required String text,
    required VoidCallback onClick}) {
  return ElevatedButton(
      onPressed: () => {onClick()},
      style: primaryRaisedButtonStyle(context),
      child: Text(text));
}

ButtonStyle primaryRaisedButtonStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Theme.of(context).primaryColor);
}

ElevatedButton socialMediaButton(
    {required BuildContext context,
    required String text,
    required IconData icon,
    required VoidCallback onClick}) {
  return ElevatedButton.icon(
    onPressed: () => {onClick()},
    style: ElevatedButton.styleFrom(
        foregroundColor: Theme.of(context).colorScheme.onBackground,
        backgroundColor: Theme.of(context).colorScheme.background),
    label: Text(text),
    icon: Icon(icon),
  );
}
