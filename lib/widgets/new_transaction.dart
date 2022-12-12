import 'package:expense_planner/widgets/adaptive_button.dart';
import 'package:expense_planner/widgets/adaptive_textfield.dart';
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
  final TextEditingController titleController = TextEditingController();
  final amountController = TextEditingController();

  // the function that takes input from textfield
  void _submitInput() {
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
  void presentDatePicker() {
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
            // because in smaller screens keyboard make textfield disappears
            bottom: keyboardHeight + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /* controller: titleController,
                onSubmitted: (_) => _submitInput(),
                decoration: const InputDecoration(labelText: 'Title'), */
              AdaptiveTextField(
                label: 'Title',
                aController: titleController,
                inputAction: TextInputAction.next,
                submitInput: _submitInput,
                textInputType: TextInputType.name,
              ),

              /*  controller: amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitInput(),
                decoration: const InputDecoration(labelText: 'Amount'), */
              AdaptiveTextField(
                label: 'Amount',
                aController: amountController,
                inputAction: TextInputAction.next,
                submitInput: _submitInput,
                textInputType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                          'Date : ${DateFormat().add_yMd().format(_selectedDate)}')),
                  TextButton(
                    onPressed: presentDatePicker,
                    child: const Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              AdaptiveButton(
                submitInput: _submitInput,
                label: 'Add Transaction',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
