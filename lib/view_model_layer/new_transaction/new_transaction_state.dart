import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_transaction_state.freezed.dart';

@freezed
abstract class NewTransactionState with _$NewTransactionState {
  const factory NewTransactionState({
    required DateTime selectedDate,
    required TextEditingController titleController,
    required TextEditingController amountController,
    required FocusNode nodeTitle,
    required FocusNode nodeAmount,
  }) = _NewTransactionState;
}
