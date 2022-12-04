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
  // List<Transaction> transactions = [];
  final List<Transaction> transactions = [
    Transaction(
        id: 't1', title: 'New Shoes1', amount: 2005, date: DateTime.now()),
    Transaction(
      id: 't12',
      title: 'New Shoes2',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't13',
      title: 'New Shoes3',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't14',
      title: 'New Shoes4',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't15',
      title: 'New Shoes5',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't16',
      title: 'New Shoes6',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 7)),
    ),
    Transaction(
      id: 't17',
      title: 'New Shoes7',
      amount: 20,
      date: DateTime.now().subtract(const Duration(days: 9)),
    ),
  ];
  
 /*  List<Transaction> get transactions {
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
 */
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

  var showChart = true;

  @override
  Widget build(BuildContext context) {
    // storing appbar into a variable to get its height using preferredSize
    var appBar2 = AppBar(
      title: const Text('Flutter App'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: addIcon,
          tooltip: 'Add New Transaction',
        ),
        IconButton(
          onPressed: _resetTransactions,
          icon: const Icon(Icons.delete),
          tooltip:'Erase All Transactions'
        )
      ],
    );

    // getting appbar height value using preferredSize
    var appbarHeight = appBar2.preferredSize.height;
    // getting height of app defult padding from MediaQuery
    var paddingHeight = MediaQuery.of(context).padding.top;
    // getting height of the body depending of the device size from MediaQuery
    var bodyHeight =
        MediaQuery.of(context).size.height - appbarHeight - paddingHeight;

    // getting the orientation of the device from MediaQuery
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    /* storing the widget that contains the list of transaction into var
    bec it's used multiple times in the body */
    var txlistWidget = SizedBox(
      height: bodyHeight * 0.7,
      child: TransactionList(transactions, _deleteTrasaction),
    );

    /* storing the widget that contains the list of transaction into function
    bec it's used multiple times in the body and the height is not the same */
    SizedBox chartWidget(double h) {
      return SizedBox(
        height: h,
        child: Chart(_recentTranscations),
      );
    }

    return Scaffold(
      appBar: appBar2,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /* showing the switch that show and hide the chart
            only when the device is on landscape mode */
            if (isLandscape)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text('Show Chart'),
                Switch(
                    value: showChart,
                    onChanged: (val) {
                      setState(() {
                        showChart = val;
                      });
                    }),
              ]),

            // if the mobile isn't in landscape mode, show the chart and list together
            if (!isLandscape) chartWidget(bodyHeight * 0.3),
            if (!isLandscape) txlistWidget,

            /* if the mobile is in landscape mode show the card only or the list only
             depending on the switch state */
            if (isLandscape)
              showChart ? chartWidget(bodyHeight * 0.7) : txlistWidget,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add New Transaction',
        onPressed: () => _startAddNewTransaction(context),
        child: addIcon,
      ),
    );
  }
}
