import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  // pecentage -> pct
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          // spent amount text
          Text(spendAmount.toStringAsFixed(0),
              style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 4),
          //  spending precentage bar of total in the week
          SizedBox(
            height: 60,
            width: 10,
            child: Stack(
              children: [
                // gray backround
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                // progress indicator
                FractionallySizedBox(
                  heightFactor: spendingPctOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                )
              ],
            ),
          ),
          // day title text
          Text(label, style: Theme.of(context).textTheme.headline6),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}
