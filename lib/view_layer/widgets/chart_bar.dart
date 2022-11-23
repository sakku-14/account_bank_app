import 'package:account_book_app/view_model_layer/chart_bar/chart_bar_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChartBar extends ConsumerWidget {
  final String label;
  final int spendingAmount;
  final double spendingPctOfTotal;
  final double areaHeight;

  ChartBar(this.label, this.spendingAmount, this.spendingPctOfTotal,
      this.areaHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // notifier
    final ChartBarNotifier chartBarNotifier =
        ref.watch(chartBarProvider.notifier);

    // 消費金額
    final spendAmount = SizedBox(
      height: areaHeight * 0.1,
      child: FittedBox(
        child: Text(chartBarNotifier.getShowAmount(spendingAmount)),
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
            color: chartBarNotifier.getWeekDayColor(context, label),
            fontWeight: chartBarNotifier.getWeekDayFontWeight(label),
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
