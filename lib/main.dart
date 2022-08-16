import 'dart:io';

import 'package:account_book_app/models/transaction.dart';
import 'package:account_book_app/widgets/chart.dart';
import 'package:account_book_app/widgets/new_transaction.dart';
import 'package:account_book_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
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
      amount: 5000,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Book',
      amount: 1600,
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Transaction(
      id: 't3',
      title: 'Food',
      amount: 1020,
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    Transaction(
      id: 't4',
      title: 'Cloth',
      amount: 5030,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Transaction(
      id: 't5',
      title: 'Bike',
      amount: 15000,
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    Transaction(
      id: 't6',
      title: 'iPhone',
      amount: 21000,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    Transaction(
      id: 't7',
      title: 'PC',
      amount: 30000,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't8',
      title: 'PC',
      amount: 250000,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
    Transaction(
      id: 't9',
      title: 'PC',
      amount: 210000,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];

  _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _addNewTransaction(String title, int amount, DateTime date) {
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

  List<Transaction> get _recentTransactions {
    var sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return _userTransactions
        .where((element) => element.date.isAfter(sevenDaysAgo))
        .toList();
  }

  double getChartHeight(MediaQueryData mediaQuery, bool isIOS, double iosHeight,
      double androidHeight) {
    if (isIOS) {
      return (mediaQuery.size.height - iosHeight - mediaQuery.padding.top) *
          0.3;
    } else {
      return (mediaQuery.size.height - androidHeight - mediaQuery.padding.top) *
          0.3;
    }
  }

  double getTransactionListHeight(MediaQueryData mediaQuery, bool isPortrait,
      bool isIOS, double iosHeight, double androidHeight) {
    if (isPortrait) {
      if (isIOS) {
        return (mediaQuery.size.height - iosHeight - mediaQuery.padding.top) *
            0.7;
      } else {
        return (mediaQuery.size.height -
                androidHeight -
                mediaQuery.padding.top) *
            0.7;
      }
    } else {
      if (isIOS) {
        return mediaQuery.size.width - iosHeight - mediaQuery.padding.top;
      } else {
        return mediaQuery.size.width - androidHeight - mediaQuery.padding.top;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    const titleName = "１週間家計簿";

    // タイトルバー
    final appBarForIOS = CupertinoNavigationBar(
      middle: const Text(titleName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => _startAddNewTransaction(context),
            child: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
    );
    final appBarForAndroid = AppBar(
      title: const Text(titleName),
    );
    double transactionListHeight() {
      if (isLandscape) {
        if (Platform.isIOS) {
          return mediaQuery.size.height -
              appBarForIOS.preferredSize.height -
              mediaQuery.padding.top;
        } else {
          return mediaQuery.size.height -
              appBarForAndroid.preferredSize.height -
              mediaQuery.padding.top;
        }
      } else {
        if (Platform.isIOS) {
          return (mediaQuery.size.height -
                  appBarForIOS.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7;
        } else {
          return (mediaQuery.size.height -
                  appBarForAndroid.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7;
        }
      }
    }

    // メインコンテンツ
    final appBody = Column(
      children: <Widget>[
        SizedBox(
          height: Platform.isIOS
              ? appBarForIOS.preferredSize.height + 20
              : appBarForAndroid.preferredSize.height + 20,
        ),
        // チャート表示部
        isLandscape
            ? Container()
            : SizedBox(
                height: getChartHeight(
                    mediaQuery,
                    Platform.isIOS,
                    appBarForIOS.preferredSize.height,
                    appBarForAndroid.preferredSize.height),
                child: Chart(_recentTransactions),
              ),
        // トランザクションリスト表示部
        SizedBox(
          height: transactionListHeight(),
          child: TransactionList(
            _userTransactions,
            _deleteTransaction,
            isLandscape,
          ),
        ),
      ],
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBarForIOS,
            child: appBody,
          )
        : Scaffold(
            appBar: appBarForAndroid,
            body: appBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              tooltip: 'Add transaction',
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            ),
          );
  }
}
