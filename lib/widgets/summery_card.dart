import 'package:flutter/material.dart';

class SummeryCard extends StatelessWidget {
  const SummeryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.blue,
        // ignore: sort_child_properties_last
        child: Text('CHART!'),
        elevation: 5,
      ),
    );
  }
}
