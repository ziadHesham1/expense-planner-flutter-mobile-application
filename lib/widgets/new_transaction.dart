import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function _addNewTransaction;
  NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  // the function that takes input from textfield
  // and add it to the list of tarnsaction
  void sumbitInput() {
    var enteredTitle = titleController.text;
    if (enteredTitle.isEmpty || (amountController.text).isEmpty) {
      return;
    } else {
      var enteredAmount = double.parse(amountController.text);

      _addNewTransaction(enteredTitle, enteredAmount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => sumbitInput(),
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: amountController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => sumbitInput(),
              decoration: const InputDecoration(
                labelText: 'Amount',
              ),
            ),
            TextButton(
              onPressed: sumbitInput,
              child: const Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
