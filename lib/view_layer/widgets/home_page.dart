import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:account_book_app/view_model_layer/home_page/home_page_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

import 'package:account_book_app/view_layer/widgets/chart.dart';
import 'package:account_book_app/view_layer/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

const String transactionsName = 'transactions';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // state
    final homePageState = ref.watch(homePageProvider);
    // notifier
    final homePageNotifier = ref.watch(homePageProvider.notifier);

    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    // タイトルバー
    final appBarForIOS = CupertinoNavigationBar(
      middle: Text(homePageState.title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            onTap: () => homePageNotifier.startAddNewTransaction(context),
            child: const Icon(CupertinoIcons.add),
          ),
        ],
      ),
    );
    final appBarForAndroid = AppBar(
      title: Text(homePageState.title),
    );

    // メインコンテンツ
    final appBody = ValueListenableBuilder(
        valueListenable: Hive.box<Transaction>(transactionsName).listenable(),
        builder: (context, Box<Transaction> box, _) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: homePageNotifier.getChartUpperSpace(
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
                      height: homePageNotifier.getChartHeight(
                          mediaQuery,
                          Platform.isIOS,
                          appBarForIOS.preferredSize.height,
                          appBarForAndroid.preferredSize.height),
                      child: Chart(
                          homePageNotifier.recentTransactions(),
                          homePageNotifier.getChartHeight(
                              mediaQuery,
                              Platform.isIOS,
                              appBarForIOS.preferredSize.height,
                              appBarForAndroid.preferredSize.height)),
                    ),
              // トランザクションリスト表示部
              SizedBox(
                height: homePageNotifier.getTransactionListHeight(
                    mediaQuery,
                    isLandscape,
                    Platform.isIOS,
                    appBarForIOS.preferredSize.height,
                    appBarForAndroid.preferredSize.height),
                child: TransactionList(
                  box.values.toList(),
                  homePageNotifier.deleteTransaction,
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
              onPressed: () => homePageNotifier.startAddNewTransaction(context),
              tooltip: 'Add transaction',
              foregroundColor: Colors.white,
              child: const Icon(Icons.add),
            ),
          );
  }
}
