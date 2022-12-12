import 'package:expense_planner/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final Function() submitInput;
  final String label;

  const AdaptiveButton({
    required this.submitInput,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoButton(
            onPressed: submitInput,
            color: Theme.of(context).primaryColor,
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: submitInput,
            child: Text(label),
          );
  }
}
