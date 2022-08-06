import 'dart:ffi';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:account_book_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  // 曜日毎の消費金額を集計する
  List<Map<String, Object>> get daylyTransactionList {
    return List.generate(7, (index) {
      final formatOfDayOfWeek = DateFormat.E();
      final theDay = DateTime.now().subtract(Duration(days: index));
      var dayAmount = 0.0;

      for (var transaction in recentTransactions) {
        // 同じ曜日のみ集計
        if (transaction.date.weekday == theDay.weekday) {
          dayAmount += transaction.amount;
        }
      }

      return {
        'day': formatOfDayOfWeek
            .format(DateTime.now().subtract(Duration(days: index)))
            .toString(),
        'amount': dayAmount,
      };
    }).toList();
  }

  double get totalSpending {
    var total = 0.0;
    for (var transaction in recentTransactions) {
      total += transaction.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: daylyTransactionList.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'].toString(),
                double.parse(data['amount'].toString()),
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
