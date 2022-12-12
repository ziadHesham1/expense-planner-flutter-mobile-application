import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  // ignore: unused_field
  final List<Transaction> _recentTransactions;

  const Chart(this._recentTransactions, {super.key});
  final dayKey = 'day';
  final amountKey = 'amount';
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var tx in _recentTransactions) {
        var isSameDay = tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year;
        if (isSameDay) {
          totalSum += tx.amount;
        }
      }
      return {
        dayKey: DateFormat().add_E().format(weekDay),
        amountKey: totalSum
      };
    }).reversed.toList();
  }

  double get maxSpending {
    return groupedTransactionValues.fold(0, (sum, item) {
      double a = double.parse(item[amountKey].toString());
      return sum + a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...groupedTransactionValues.map((e) {
                String d = e[dayKey].toString();
                double a = double.parse(e[amountKey].toString());
                double pct = maxSpending == 0 ? 0.0 : (a / maxSpending);
                return Expanded(child: ChartBar(d, a, pct));
              })
            ],
          ),
        ),
      );
    }
  
}
