import 'package:expense_planner/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController aController;
  final Function submitInput;
  final TextInputAction inputAction;

  final String label;
  final TextInputType textInputType;

  const AdaptiveTextField(
      {required this.label,
      required this.aController,
      required this.inputAction,
      required this.submitInput,
      required this.textInputType,
      super.key});

  @override
  Widget build(BuildContext context) {
    return isIOS
        // if the app is running on Android
        ? CupertinoTextField(
            textInputAction: inputAction,
            keyboardType: textInputType,
            controller: aController,
            onSubmitted: (_) => submitInput(),
            placeholder: label,
          )
        // if the app is running on IOS
        : TextField(
            textInputAction: inputAction,
            keyboardType: textInputType,
            controller: aController,
            onSubmitted: (_) => submitInput(),
            decoration: InputDecoration(labelText: label),
          );
  }
}
