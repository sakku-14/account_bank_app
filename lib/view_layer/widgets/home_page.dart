import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

import 'package:account_book_app/view_layer/widgets/chart.dart';
import 'package:account_book_app/view_layer/widgets/new_transaction.dart';
import 'package:account_book_app/view_layer/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

const String transactionsName = 'transactions';

class HomePage extends ConsumerWidget {
  const HomePage(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  // VM-Notifierに移行するメソッド
  _deleteTransaction(Transaction transaction) {
    final box = Hive.box<Transaction>(transactionsName);
    final int index = box.values.toList().indexOf(transaction);
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
  Widget build(BuildContext context, WidgetRef ref) {
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
