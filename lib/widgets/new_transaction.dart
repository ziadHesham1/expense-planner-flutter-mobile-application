import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  const NewTransaction(this._addNewTransaction, {Key? key}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  // the function that takes input from textfield
  void _sumbitInput() {
    var enteredTitle = titleController.text;
    if (enteredTitle.isEmpty ||
        (amountController.text).isEmpty ||
        double.tryParse(amountController.text) == null) {
      return;
    } else {
      var enteredAmount = double.parse(amountController.text);
      widget._addNewTransaction(enteredTitle, enteredAmount, _selectedDate);

      Navigator.of(context).pop();
    }
  }

  var _selectedDate = DateTime.now();
  void pesentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
        showToast(value.toString(), context: context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // because in smaller screens keyboard make textfeild disappears
            bottom: keyboardHeight + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (_) => _sumbitInput(),
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _sumbitInput(),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Row(
                // mainAxisAlignment: M  ainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                          'Date : ${DateFormat().add_yMd().format(_selectedDate)}')),
                  TextButton(
                    onPressed: pesentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: _sumbitInput,
                child: const Text('Add Transaction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
