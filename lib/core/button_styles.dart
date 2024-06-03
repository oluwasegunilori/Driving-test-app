import 'package:flutter/material.dart';

ButtonStyle primaryRaisedButtonStyle(BuildContext context) {
  return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Theme.of(context).primaryColor);
}
