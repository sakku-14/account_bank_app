import 'dart:io';

import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:account_book_app/view_layer/widgets/new_transaction.dart';
import 'package:account_book_app/view_model_layer/home_page/home_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

const String transactionsName = 'transactions';

class HomePageNotifier extends StateNotifier<HomePageState> {
  HomePageNotifier() : super(const HomePageState());

  void addNewTransaction(String title, int amount, DateTime date) async {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: date,
    );
    var box = Hive.box<Transaction>(transactionsName);
    box.add(newTx);
  }

  void startAddNewTransaction(BuildContext ctx) async {
    return showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: NewTransaction(addNewTransaction),
        );
      },
    );
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
}

final homePageProvider =
    StateNotifierProvider.autoDispose<HomePageNotifier, HomePageState>(
  (ref) => HomePageNotifier(),
);
