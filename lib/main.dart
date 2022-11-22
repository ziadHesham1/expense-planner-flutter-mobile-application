import 'widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'widgets/summery_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Personal expenses'),
        actions: const [Icon(Icons.add)],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SummeryCard(),
          TransactionsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    ));
  }
}
