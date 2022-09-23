import 'dart:io';

import 'package:account_book_app/models/transaction.dart';
import 'package:account_book_app/widgets/chart.dart';
import 'package:account_book_app/widgets/new_transaction.dart';
import 'package:account_book_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/adapters.dart';

const String transactionsName = 'transactions';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>(transactionsName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ja"),
      ],
      // 初期画面
      home: const MyHomePage(title: 'Personal Expense'),
      // ルーティング
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => const MyHomePage(
              title: 'Personal Expense',
            ),
      },
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
  _deleteTransaction(int index) {
    final box = Hive.box<Transaction>(transactionsName);
    box.deleteAt(index);
  }

  _addNewTransaction(String title, int amount, DateTime date) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    var box = Hive.box<Transaction>(transactionsName);
    box.add(newTx);
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
    var box = Hive.box<Transaction>(transactionsName);
    return box.values
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

  double getTransactionListHeight(MediaQueryData mediaQuery, bool isLandscape,
      bool isIOS, double iosHeight, double androidHeight) {
    if (isLandscape) {
      if (Platform.isIOS) {
        return mediaQuery.size.height - iosHeight - mediaQuery.padding.top;
      }
      return mediaQuery.size.height - androidHeight - mediaQuery.padding.top;
    } else {
      if (Platform.isIOS) {
        return (mediaQuery.size.height - iosHeight - mediaQuery.padding.top) *
            0.7;
      }
      return (mediaQuery.size.height - androidHeight - mediaQuery.padding.top) *
          0.7;
    }
  }

  double getChartUpperSpace(MediaQueryData mediaQuery, bool isLandscape,
      bool isIOS, double iosHeight, double androidHeight) {
    if (isIOS) {
      return iosHeight + mediaQuery.padding.top;
    }
    return androidHeight + mediaQuery.padding.top;
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

    // メインコンテンツ
    final appBody = ValueListenableBuilder(
        valueListenable: Hive.box<Transaction>(transactionsName).listenable(),
        builder: (context, Box<Transaction> box, _) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: getChartUpperSpace(
                    mediaQuery,
                    isLandscape,
                    Platform.isIOS,
                    appBarForIOS.preferredSize.height,
                    appBarForAndroid.preferredSize.height),
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
                      child: Chart(
                          _recentTransactions,
                          getChartHeight(
                              mediaQuery,
                              Platform.isIOS,
                              appBarForIOS.preferredSize.height,
                              appBarForAndroid.preferredSize.height)),
                    ),
              // トランザクションリスト表示部
              SizedBox(
                height: getTransactionListHeight(
                    mediaQuery,
                    isLandscape,
                    Platform.isIOS,
                    appBarForIOS.preferredSize.height,
                    appBarForAndroid.preferredSize.height),
                child: TransactionList(
                  box.values.toList(),
                  _deleteTransaction,
                  isLandscape,
                ),
              ),
            ],
          );
        });

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
