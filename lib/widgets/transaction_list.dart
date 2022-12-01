import 'package:expense_planner/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final Function _deleteTrasaction;
  final List<Transaction> transactions;

  const TransactionList(this.transactions, this._deleteTrasaction, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Image.asset(
                    'assets/img/wait.png',
                    // waiting.png
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              reverse: true,
              itemCount: transactions.length,
              itemBuilder: (BuildContext context, int index) {
                var tx = transactions[index];
                var today = DateTime.now();
                var isToday = tx.date.day == today.day &&
                    tx.date.month == today.month &&
                    tx.date.year == today.year;
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
                  isToday ? 'Today' : DateFormat.yMd().format(tx.date),
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                );
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(child: amountText),
                      ),
                    ),
                    title: titleText,
                    subtitle: dateText,
                    trailing: IconButton(
                        onPressed: () {
                          _deleteTrasaction(tx.id);
                        },
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).errorColor),
                  ),
                );
              },
            ),
    );
  }
}
