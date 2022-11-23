import 'package:account_book_app/view_model_layer/chart_bar/chart_bar_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ChartBarNotifier extends StateNotifier<ChartBarState> {
  ChartBarNotifier() : super(const ChartBarState());

  String getShowAmount(int spendingAmount) {
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

  Color? getWeekDayColor(BuildContext context, String weekday) {
    if (isToday(weekday)) {
      return Theme.of(context).colorScheme.secondary;
    }
    return null;
  }

  FontWeight? getWeekDayFontWeight(String weekday) {
    if (isToday(weekday)) {
      return FontWeight.bold;
    }
    return null;
  }
}

final chartBarProvider =
    StateNotifierProvider.autoDispose<ChartBarNotifier, ChartBarState>(
        (ref) => ChartBarNotifier());
