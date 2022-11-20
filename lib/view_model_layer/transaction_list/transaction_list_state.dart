import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'transaction_list_state.freezed.dart';

@freezed
abstract class TransactionListState with _$TransactionListState {
  factory TransactionListState({
    required Box<Transaction> transactionsBox,
  }) = _TransactionListState;
}
