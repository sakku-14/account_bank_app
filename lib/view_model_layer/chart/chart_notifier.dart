import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:account_book_app/domain_layer/repositories/transaction_aggregate/transaction_repository.dart';
import 'package:account_book_app/view_model_layer/chart/chart_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

const String transactionsName = 'transactions';

class ChartNotifier extends StateNotifier<ChartState> {
  ChartNotifier()
      : super(ChartState(
            transactionRepository: TransactionRepository(transactionsName)));

  Future<List<Transaction>> recentTransactions() async {
    var sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
    var transactions = await state.transactionRepository.findAll();
    return transactions
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
  Future<List<Map<String, dynamic>>> dailyTransactionList() async {
    var recentTransactions = await this.recentTransactions();

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

  Future<int> totalSpending() async {
    var total = 0;
    var recentTransactions = await this.recentTransactions();

    for (var transaction in recentTransactions) {
      total += transaction.amount;
    }
    return total;
  }

  Future<double> getSpendRateForWeek(int spendAmount) async {
    int amountForWeek = await totalSpending();
    if (amountForWeek == 0) {
      return 0;
    }
    return spendAmount / amountForWeek;
  }
}

final chartProvider =
    StateNotifierProvider.autoDispose<ChartNotifier, ChartState>(
        (ref) => ChartNotifier());
