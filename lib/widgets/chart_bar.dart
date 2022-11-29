import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(label, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 4),
          Text(spendAmount.toString(),
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 4),
          Text(spendingPctOfTotal.toString(),
              style: Theme.of(context).textTheme.headline6),
        ],
      ),
    );
  }
}
