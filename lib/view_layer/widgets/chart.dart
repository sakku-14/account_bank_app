import 'package:account_book_app/view_model_layer/chart/chart_notifier.dart';
import 'package:account_book_app/view_model_layer/chart/chart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'chart_bar.dart';

class Chart extends ConsumerWidget {
  final double areaHeight;

  const Chart(this.areaHeight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // state
    final ChartState chartState = ref.watch(chartProvider);
    // notifier
    final ChartNotifier chartNotifier = ref.watch(chartProvider.notifier);

    // 一週間分のチャート部
    final chartContents = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: chartNotifier.dailyTransactionList().map((data) {
        return Flexible(
          fit: FlexFit.tight,
          child: ChartBar(
            data['day'].toString(),
            int.parse(data['amount'].toString()),
            chartNotifier.getSpendRateForWeek(data['amount'] as int),
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
