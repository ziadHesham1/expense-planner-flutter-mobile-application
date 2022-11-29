import 'package:expense_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  // ignore: unused_field
  final List<Transaction> _recentTranscations;

  const Chart(this._recentTranscations, {super.key});
  final dayKey = 'day';
  final amountKey = 'amount';
  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var tx in _recentTranscations) {
        if (tx.date.day == weekDay.day &&
            tx.date.month == weekDay.month &&
            tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }
      return {
        dayKey: DateFormat().add_E().format(weekDay),
        amountKey: totalSum
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_print
    print(groupedTransactionValues);
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Row(
          children: [
            ...groupedTransactionValues.map((e) {
              String d = e[dayKey].toString();
              double a = double.parse(e[amountKey].toString());
              return  ChartBar(d, a, 2);
            })
          ],
        ),
      ),
    );
  }
}
