import 'package:account_book_app/models/transaction.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Personal Expense'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Grocery',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account Book App"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Card(
              child: Text('Chart Space'),
            ),
            Card(
              child: ListTile(
                leading: Text(_userTransactions[0].amount.toString()),
                title: Text(_userTransactions[0].title),
                subtitle: Text(_userTransactions[0].date.toString()),
                trailing: const Icon(Icons.delete),
              ),
            ),
            Card(
              child: ListTile(
                leading: Text(_userTransactions[1].amount.toString()),
                title: Text(_userTransactions[1].title),
                subtitle: Text(_userTransactions[1].date.toString()),
                trailing: const Icon(Icons.delete),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add transaction',
        child: const Icon(Icons.add),
      ),
    );
  }
}
