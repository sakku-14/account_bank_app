import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';

import '../../domain_layer/models/transaction_aggregate/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  final double areaHeight;

  Chart(this.recentTransactions, this.areaHeight);

  // 曜日毎の消費金額を集計する
  List<Map<String, Object>> get daylyTransactionList {
    return List.generate(7, (index) {
      initializeDateFormatting('ja');
      var dayAmount = 0;

      for (var transaction in recentTransactions) {
        // 同じ曜日のみ集計
        if (transaction.date.weekday == ((index + 6) % 7) + 1) {
          dayAmount += transaction.amount;
        }
      }

      return {
        'day': getWeekday(((index + 6) % 7) + 1),
        'amount': dayAmount,
      };
    }).toList();
  }

  String getWeekday(int weekday) {
    switch (weekday) {
      case 1:
        return '月';
      case 2:
        return '火';
      case 3:
        return '水';
      case 4:
        return '木';
      case 5:
        return '金';
      case 6:
        return '土';
      case 7:
        return '日';
      default:
        return '';
    }
  }

  int get totalSpending {
    var total = 0;
    for (var transaction in recentTransactions) {
      total += transaction.amount;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    // 一週間分のチャート部
    final chartContents = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: daylyTransactionList.map((data) {
        return Flexible(
          fit: FlexFit.tight,
          child: ChartBar(
            data['day'].toString(),
            int.parse(data['amount'].toString()),
            totalSpending == 0 ? 0 : (data['amount'] as int) / totalSpending,
            areaHeight * 0.9,
          ),
        );
      }).toList(),
    );

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(areaHeight * 0.05),
      child: Padding(
        padding: EdgeInsets.all(areaHeight * 0.05),
        child: chartContents,
      ),
    );
  }
}
