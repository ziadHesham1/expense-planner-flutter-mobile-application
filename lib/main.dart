import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/models/transaction.dart';
import 'package:expense_planner/widgets/transaction_list.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: const MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
            titleTextStyle: ThemeData.light()
                .textTheme
                .copyWith(
                  headline6: const TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
                .headline6),
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}

var addIcon = const Icon(Icons.add);

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

@override
class _MyHomePageState extends State<MyHomePage> {
  // final List<Transaction> transactions = [
  //   Transaction(
  //       id: 't1', title: 'New Shoes', amount: 2005, date: DateTime.now()),
  //   Transaction(
  //     id: 't12',
  //     title: 'New Shoes',
  //     amount: 20,
  //     date: DateTime.now().subtract(const Duration(days: 1)),
  //   ),
  //   Transaction(
  //     id: 't13',
  //     title: 'New Shoes',
  //     amount: 20,
  //     date: DateTime.now().subtract(const Duration(days: 1)),
  //   ),
  //   Transaction(
  //     id: 't14',
  //     title: 'New Shoes',
  //     amount: 20,
  //     date: DateTime.now().subtract(const Duration(days: 3)),
  //   ),
  //   Transaction(
  //     id: 't15',
  //     title: 'New Shoes',
  //     amount: 20,
  //     date: DateTime.now().subtract(const Duration(days: 5)),
  //   ),
  //   Transaction(
  //     id: 't16',
  //     title: 'New Shoes',
  //     amount: 20,
  //     date: DateTime.now().subtract(const Duration(days: 7)),
  //   ),
  //   Transaction(
  //     id: 't17',
  //     title: 'New Shoes',
  //     amount: 20,
  //     date: DateTime.now().subtract(const Duration(days: 9)),
  //   ),
  // ];
  List<Transaction> get transactions {
    var today = DateTime.now();
    return List.generate(10, (index) {
      double currentMinute = double.parse(DateFormat.m().format(today));
      var txDate = today.subtract(Duration(days: index));
      return Transaction(
        id: 'id-$today',
        title: DateFormat.EEEE().format(txDate),
        amount: currentMinute * index + 1,
        // amount: 1.0,
        date: txDate,
      );
    });
  }

  List<Transaction> get _recentTranscations {
    DateTime aWeekAgo = DateTime.now().subtract(const Duration(days: 7));
    return transactions.where(
      (tx) {
        return tx.date.isAfter(aWeekAgo);
      },
    ).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: 'T-$chosenDate', title: title, amount: amount, date: chosenDate);
    setState(() {
      transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  void _resetTransactions() {
    setState(() {
      transactions.clear();
    });
  }

  void _deleteTrasaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    var appBar2 = AppBar(
      title: const Text('Flutter App'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: addIcon,
        ),
        IconButton(
          onPressed: _resetTransactions,
          icon: const Icon(Icons.delete),
        )
      ],
    );
    var appbarHeight = appBar2.preferredSize.height;
    var paddingHeight = MediaQuery.of(context).padding.top;
    var bodyHeight =
        MediaQuery.of(context).size.height - appbarHeight - paddingHeight;

    return Scaffold(
      appBar: appBar2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: bodyHeight * 0.3,
              child: Chart(_recentTranscations),
            ),
            SizedBox(
              height: bodyHeight * 0.7,
              child: TransactionList(transactions, _deleteTrasaction),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        child: addIcon,
      ),
    );
  }
}
