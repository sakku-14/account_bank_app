import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    // 消費金額
    final spendAmount = SizedBox(
      height: 20,
      child: FittedBox(
        child: Text(spendingAmount.toString()),
      ),
    );

    // チャートバー上下マージン
    const chartBarMargin = SizedBox(
      height: 4,
    );

    // 消費割合の棒グラフ
    final chartBarGraph = SizedBox(
      height: 60,
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
    final weekDay = Text(label);

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
