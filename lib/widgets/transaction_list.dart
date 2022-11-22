import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactionsList = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
  ];
  TransactionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...transactionsList.map(
          (e) {
            return SizedBox(
              child: Card(
                elevation: 20,
                child: cardChild(e),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget cardChild(Transaction e) {
    return Row(
      children: [
        //the circle that contains the amount in $
        //the decoration
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.purple,
          ),
          //the text inside the circle
          child: Text(
            '\$${e.amount}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //the title and date
        // the container added do be able to add margin
        Container(
          margin: const EdgeInsets.all(10),
          // the column is to contain 3 text for title, date and time.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // title text
              Text(
                e.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // date text
              // to veiw date with month day,year => 'July 10, 1996'
              Text(DateFormat().add_yMMMMd().format(e.date)),
              // to veiw time with time AM/PM => '5:08 PM'
              Text(DateFormat().add_jm().format(e.date)),
            ],
          ),
        )
      ],
    );
  }
}
