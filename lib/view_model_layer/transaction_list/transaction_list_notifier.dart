import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:account_book_app/domain_layer/repositories/transaction_aggregate/transaction_repository.dart';
import 'package:account_book_app/view_model_layer/transaction_list/transaction_list_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String transactionsName = 'transactions';

class TransactionListNotifier extends StateNotifier<TransactionListState> {
  TransactionListNotifier()
      : super(TransactionListState(
            transactionRepository: TransactionRepository(transactionsName)));

  void deleteTransaction(Transaction transaction) {
    state.transactionRepository.deleteTransaction(transaction);
  }

  String getShowAmount(int amount) {
    if (amount / 1000 < 1) {
      return amount.toString();
    }
    if (amount % 10000 == 0) {
      return '${(amount / 10000).toStringAsFixed(0)}万';
    }
    return '${(amount / 10000).toStringAsFixed(1)}万';
  }
}

final transactionListProvider = StateNotifierProvider.autoDispose<
    TransactionListNotifier, TransactionListState>(
  (ref) => TransactionListNotifier(),
);
