import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

ElevatedButton primaryButton(
    {required BuildContext context,
    required String text,
    ButtonStyle? style,
    required VoidCallback onClick}) {
  return ElevatedButton(
      onPressed: () => {onClick()},
      style: style ?? primaryRaisedButtonStyle(context),
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

Container backIcon(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface, // Background color
        shape: BoxShape.circle, // Circle shape for rounded button
      ),
      child: IconButton(
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          }
        },
        icon: Icon(
          MdiIcons.chevronLeft,
          size: 26,
        ),
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }