import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  // percentage -> pct
  final double spendingPctOfTotal;

  const ChartBar(this.label, this.spendAmount, this.spendingPctOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      var chartHeight = constraints.maxHeight;
      var spacingHeight = chartHeight * 0.05;
      var textHeight = chartHeight * 0.15;

      return Column(
        children: [
          // spent amount text
          SizedBox(
            height: textHeight,
            child: FittedBox(
              child: Text('\$${spendAmount.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.headline6),
            ),
          ),

          SizedBox(height: spacingHeight),
          // bar displays the spending percentage of total in the week
          SizedBox(
            height: chartHeight * 0.5,
            width: 10,
            child: Stack(
              children: [
                // gray background
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
          SizedBox(height: spacingHeight),
          // day title text
          SizedBox(
            height: textHeight,
            child: FittedBox(
                child:
                    Text(label, style: Theme.of(context).textTheme.headline6)),
          ),
        ],
      );
    });
  }
}
