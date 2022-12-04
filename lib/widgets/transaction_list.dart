import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function _deleteTrasaction;
  final List<Transaction> transactions;

  const TransactionList(this.transactions, this._deleteTrasaction, {super.key});
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            var widgetHeight = constraints.maxHeight;
            return Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: widgetHeight * 0.7,
                  child: Image.asset(
                    'assets/img/wait.png',
                    // waiting.png
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (BuildContext context, int index) {
              var tx = transactions[index];
              var today = DateTime.now();
              var yesterday = DateTime.now().subtract(const Duration(days: 1));

              var isToday = tx.date.day == today.day &&
                  tx.date.month == today.month &&
                  tx.date.year == today.year;
              var isYesterday = tx.date.day == yesterday.day &&
                  tx.date.month == yesterday.month &&
                  tx.date.year == yesterday.year;

              var amountText = Text(
                '\$${tx.amount.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              );
              var titleText = Text(
                tx.title,
                style: Theme.of(context).textTheme.headline6,
              );
              var dateText = Text(
                isToday
                    ? 'Today ${DateFormat.yMd().format(tx.date)}'
                    : isYesterday
                        ? 'Yesterday ${DateFormat.yMd().format(tx.date)}'
                        : DateFormat.yMd().format(tx.date),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              );
              var time = Text(DateFormat.jm().format(tx.date));
              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () =>
                      showToast(DateFormat.m().format(today), context: context),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(child: amountText),
                    ),
                  ),
                  title: titleText,
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dateText,
                      time,
                    ],
                  ),
                  trailing: IconButton(
                      onPressed: () {
                        _deleteTrasaction(tx.id);
                        showToast('${tx.title}\'s transaction deleted',context: context);
                      },
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor),
                ),
              );
            },
          );
  }
}
