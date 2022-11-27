import 'package:account_book_app/infrastructure_layer/interfaces/i_transaction_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_state.freezed.dart';

@freezed
abstract class ChartState with _$ChartState {
  const factory ChartState({
    required ITransactionRepository transactionRepository,
  }) = _ChartState;
}
