import 'package:account_book_app/models/transaction.dart';
import 'package:account_book_app/widgets/chart.dart';
import 'package:account_book_app/widgets/new_transaction.dart';
import 'package:account_book_app/widgets/transaction_list.dart';
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
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: Colors.pinkAccent),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              button: const TextStyle(color: Colors.white),
            ),
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
              .headline6,
        ),
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
      title: 'Shoes',
      amount: 50.3,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Book',
      amount: 16.3,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't3',
      title: 'Food',
      amount: 10.8,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't4',
      title: 'Cloth',
      amount: 104.2,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: 'Bike',
      amount: 150.2,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't6',
      title: 'iPhone',
      amount: 110.0,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't7',
      title: 'PC',
      amount: 30.2,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't8',
      title: 'PC',
      amount: 30.2,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't9',
      title: 'PC',
      amount: 30.2,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];

  _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _addNewTransaction(String title, double amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  _startAddNewTransaction(BuildContext ctx) {
    return showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  _isPortrait(BuildContext ctx) {
    final size = MediaQuery.of(ctx).size;
    if (size.width < size.height) {
      return true;
    } else {
      return false;
    }
  }

  List<Transaction> get _recentTransactions {
    var sevenDaysAgo = DateTime.now().subtract(Duration(days: 7));
    return _userTransactions
        .where((element) => element.date.isAfter(sevenDaysAgo))
        .toList();
  }

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
      body: Column(
        children: <Widget>[
          // チャート表示部
          _isPortrait(context) ? Chart(_recentTransactions) : Container(),
          // トランザクションリスト表示部
          SingleChildScrollView(
            child: TransactionList(
              _userTransactions,
              _deleteTransaction,
              _isPortrait(context),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _startAddNewTransaction(context),
        tooltip: 'Add transaction',
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
