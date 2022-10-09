import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final int spendingAmount;
  final double spendingPctOfTotal;
  final double areaHeight;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      this.areaHeight);

  String get _getShowAmount {
    if (spendingAmount / 1000 < 1) {
      return spendingAmount.toString();
    }
    if (spendingAmount % 10000 == 0) {
      return '${(spendingAmount / 10000).toStringAsFixed(0)}万';
    }
    return '${(spendingAmount / 10000).toStringAsFixed(1)}万';
  }

  bool isToday(String weekday) {
    final formatOfDayOfWeek = DateFormat.E('ja');
    final weekdayOfToday = formatOfDayOfWeek.format(DateTime.now()).toString();
    if (weekdayOfToday == weekday) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    // 消費金額
    final spendAmount = SizedBox(
      height: areaHeight * 0.1,
      child: FittedBox(
        child: Text(_getShowAmount),
      ),
    );

    // チャートバー上下マージン
    final chartBarMargin = SizedBox(
      height: areaHeight * 0.05,
    );

    // 消費割合の棒グラフ
    final chartBarGraph = SizedBox(
      height: areaHeight * 0.55,
      width: 10,
      child: Stack(
        children: <Widget>[
          Container(
              decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
          )),
          FractionallySizedBox(
            heightFactor: spendingPctOfTotal,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );

    // 曜日
    final weekDay = SizedBox(
      height: areaHeight * 0.1,
      child: FittedBox(
        child: Text(
          label,
          style: TextStyle(
            color:
                isToday(label) ? Theme.of(context).colorScheme.secondary : null,
            fontWeight: isToday(label) ? FontWeight.bold : null,
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        spendAmount,
        chartBarMargin,
        chartBarGraph,
        chartBarMargin,
        weekDay,
      ],
    );
  }
}
