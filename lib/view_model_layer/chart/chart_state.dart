import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'chart_state.freezed.dart';

@freezed
abstract class ChartState with _$ChartState {
  const factory ChartState({
    required Box<Transaction> transactionsBox,
  }) = _ChartState;
}
