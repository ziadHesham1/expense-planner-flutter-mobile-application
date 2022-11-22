import 'package:flutter/material.dart';

import '../models/transaction.dart';

class NewTransactions extends StatefulWidget {
  const NewTransactions({super.key});

  @override
  State<NewTransactions> createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  var transactionsList;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Widget inputCard() {
    return Card(
      child: Column(
        children: [
          TextField(
            controller: titleController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              label: Text('Amount'),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  transactionsList.add(Transaction(
                      amount: double.parse(amountController.text),
                      title: titleController.text,
                      date: DateTime.now(),
                      id: 'card-${transactionsList.length}'));
                  // Toast.show('card-${transactionsList.length}');
                  print('click');
                });
              },
              child: const Text('Add Transaction'))
        ],
      ),
    );
  }
}
