import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:account_book_app/view_model_layer/chart/chart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:intl/date_symbol_data_local.dart';

const String transactionsName = 'transactions';

class ChartNotifier extends StateNotifier<ChartState> {
  ChartNotifier()
      : super(ChartState(
            transactionsBox: Hive.box<Transaction>(transactionsName)));

  List<Transaction> recentTransactions() {
    var sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    return state.transactionsBox.values
        .where((element) => element.date.isAfter(sevenDaysAgo))
        .toList();
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

  // 曜日毎の消費金額を集計する
  List<Map<String, dynamic>> dailyTransactionList() {
    return List.generate(7, (index) {
      initializeDateFormatting('ja');
      var dayAmount = 0;

      for (var transaction in recentTransactions()) {
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

  int totalSpending() {
    var total = 0;
    for (var transaction in recentTransactions()) {
      total += transaction.amount;
    }
    return total;
  }

  double getSpendRateForWeek(int spendAmount) {
    int amountForWeek = totalSpending();
    if (amountForWeek == 0) {
      return 0;
    }
    return spendAmount / amountForWeek;
  }
}

final chartProvider =
    StateNotifierProvider.autoDispose<ChartNotifier, ChartState>(
        (ref) => ChartNotifier());
