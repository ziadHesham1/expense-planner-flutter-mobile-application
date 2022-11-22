import 'package:flutter/material.dart';

class SummeryCard extends StatelessWidget {
  const SummeryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: const Card(
        elevation: 5,
        child: Text(
          'Summary Card',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
