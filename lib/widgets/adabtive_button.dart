import 'package:expense_planner/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdabtiveButton extends StatelessWidget {
  final Function() sumbitInput;
  final String label;
    
  const AdabtiveButton({
    required this.sumbitInput,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoButton(
            onPressed: sumbitInput,
            color: Theme.of(context).primaryColor,
            child: Text(label),
          )
        : ElevatedButton(
            onPressed: sumbitInput,
            child: Text(label),
          );
  }
}
