import 'package:expense_planner/models/transaction.dart';
import 'dart:io';

import 'package:expense_planner/widgets/new_transaction.dart';
import 'package:expense_planner/widgets/chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_planner/widgets/transaction_list.dart';

void main() => runApp(const MyApp());

var isIOS = !Platform.isIOS;

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
        id: 't1', title: 'New Shoes1', amount: 205, date: DateTime.now()),
    Transaction(
      id: 't12',
      title: 'New Shoes2',
      amount: 200,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't13',
      title: 'New Shoes3',
      amount: 220,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't14',
      title: 'New Shoes4',
      amount: 250,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't15',
      title: 'New Shoes5',
      amount: 420,
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
      amount: 120,
      date: DateTime.now().subtract(const Duration(days: 9)),
    ),
  ];

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
// ------------- Appbars ----------------------

    // storing appbar into a variable to get its height using preferredSize
    const appTitle = 'Personal Expenses';
    AppBar androidAppBar = AppBar(
      title: const Text(appTitle),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: addIcon,
          tooltip: 'Add New Transaction',
        ),
        IconButton(
            onPressed: _resetTransactions,
            icon: const Icon(Icons.delete),
            tooltip: 'Erase All Transactions')
      ],
    );

    var iosNavbar = CupertinoNavigationBar(
        middle: const Text(appTitle),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: (() => _startAddNewTransaction(context)),
              child: const Icon(CupertinoIcons.add),
            ),
          ],
        ));

// ------------- MediaQuery ----------------------

    // defining MediaQuery in a variable because its being used muliple times in this file
    var mediaQuery = MediaQuery.of(context);

    // getting appbar height value using preferredSize
    var appbarHeight = isIOS
        ? iosNavbar.preferredSize.height
        : androidAppBar.preferredSize.height;

    // getting height of app defult padding from MediaQuery
    var paddingHeight = mediaQuery.padding.top;
    // getting height of the body depending of the device size from MediaQuery
    var bodyHeight = mediaQuery.size.height - appbarHeight - paddingHeight;

    // getting the orientation of the device from MediaQuery
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

// ------------- Body variables & functions ----------------------

    /* storing the widget that contains the list of transaction into var
    bec it's used multiple times in the body */
    var txlistWidget = SizedBox(
      height: bodyHeight * 0.7,
      child: TransactionList(transactions, _deleteTrasaction),
    );
    List<Widget> buildPortraitContent(h, txlistWidget) {
      return [
        // if the mobile isn't in landscape mode, show the chart and list together
        // if (!isLandscape)
        SizedBox(
          height: h,
          child: Chart(_recentTranscations),
        ),
        txlistWidget,
      ];
    }

    List<Widget> buildLandscapeContent(h, txlistWidget) {
      return [
        /* showing the switch that show and hide the chart
            only when the device is on landscape mode */
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Show Chart', style: Theme.of(context).textTheme.headline6),
          isIOS
              ? CupertinoSwitch(
                  value: showChart,
                  onChanged: (val) {
                    setState(() {
                      showChart = val;
                    });
                  })
              : Switch(
                  value: showChart,
                  onChanged: (val) {
                    setState(() {
                      showChart = val;
                    });
                  }),
        ]),
        /* if the mobile is in landscape mode show the card only or the list only
             depending on the switch state */
        showChart
            ? SizedBox(
                height: h,
                child: Chart(_recentTranscations),
              )
            : txlistWidget,
      ];
    }

  var pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (isLandscape)
              ...buildLandscapeContent(bodyHeight * 0.7, txlistWidget),
            if (!isLandscape)
              ...buildPortraitContent(bodyHeight * 0.3, txlistWidget),
            
          ],
        ),
      ),    
    );

// ------------- Scaffolds ----------------------
    return isIOS
        ? CupertinoPageScaffold(
            navigationBar: iosNavbar,
            child: pageBody,
          )
        : Scaffold(
            appBar: androidAppBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: isIOS
                ? Container()
                : FloatingActionButton(
                    tooltip: 'Add New Transaction',
                    onPressed: () => _startAddNewTransaction(context),
                    child: addIcon,
                  ),
          );
  }
}
