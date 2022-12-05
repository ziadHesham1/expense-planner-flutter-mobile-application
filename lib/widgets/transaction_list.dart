import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

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
              return ItemTransaction(
                tx: tx,
                deleteTrasaction: _deleteTrasaction,
              );
            },
          );
  }
}
