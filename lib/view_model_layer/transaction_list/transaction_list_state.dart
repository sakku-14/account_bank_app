import 'package:account_book_app/infrastructure_layer/interfaces/i_transaction_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_list_state.freezed.dart';

@freezed
abstract class TransactionListState with _$TransactionListState {
  factory TransactionListState({
    required ITransactionRepository transactionRepository,
  }) = _TransactionListState;
}