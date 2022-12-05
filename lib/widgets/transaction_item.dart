import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class ItemTransaction extends StatelessWidget {
  const ItemTransaction({
    Key? key,
    required this.tx,
    // required this.bodyWidth,
    required Function deleteTrasaction,
  })  : _deleteTrasaction = deleteTrasaction,
        super(key: key);

  final Transaction tx;
  // final double bodyWidth;
  final Function _deleteTrasaction;

  @override
  Widget build(BuildContext context) {
    // to get device width and add to trailing delete icon a helper text if there's enough width
    var bodyWidth = MediaQuery.of(context).size.width;
    // to type beside the date today or yesterday
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
        // for testing
        // onTap: () => showToast('$bodyWidth', context: context),
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
          children: [dateText, time],
        ),
        trailing: bodyWidth > 500
            ? TextButton.icon(
                onPressed: () {
                  _deleteTrasaction(tx.id);
                  showToast('${tx.title}\'s transaction deleted',
                      context: context);
                },
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                onPressed: () {
                 showToast('${tx.title}\'s transaction deleted',
                      context: context);
                  _deleteTrasaction(tx.id);
                },
                icon: const Icon(Icons.delete),
                // color: Theme.of(context).errorColo
              ),
      ),
    );
  }
}
