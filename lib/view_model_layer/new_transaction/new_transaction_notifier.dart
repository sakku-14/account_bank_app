import 'package:account_book_app/view_model_layer/new_transaction/new_transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class NewTransactionNotifier extends StateNotifier<NewTransactionState> {
  NewTransactionNotifier()
      : super(NewTransactionState(
          selectedDate: DateTime.now(),
          titleController: TextEditingController(),
          amountController: TextEditingController(),
          nodeTitle: FocusNode(),
          nodeAmount: FocusNode(),
        ));

  void setSelectedDate(DateTime selectedDateTime) {
    state = NewTransactionState(
        selectedDate: selectedDateTime,
        titleController: state.titleController,
        amountController: state.amountController,
        nodeTitle: state.nodeTitle,
        nodeAmount: state.nodeAmount);
  }

  void submitData(Function addTx, BuildContext context) {
    if (state.amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = state.titleController.text;
    final enteredAmount = int.parse(state.amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTx(enteredTitle, enteredAmount, state.selectedDate);

    Navigator.of(context).pop();
  }

  void presentDatePicker(BuildContext context) {
    FocusScope.of(context).unfocus();
    showDatePicker(
      locale: const Locale('ja'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setSelectedDate(pickedDate);
    });
  }

  KeyboardActionsConfig buildConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: state.nodeTitle, toolbarButtons: [
          // 完了ボタン
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: const Text('完了'),
            );
          },
        ]),
        KeyboardActionsItem(focusNode: state.nodeAmount, toolbarButtons: [
          // 完了ボタン
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: const Text('完了'),
            );
          },
        ]),
      ],
    );
  }
}

final newTransactionProvider = StateNotifierProvider.autoDispose<
    NewTransactionNotifier,
    NewTransactionState>((ref) => NewTransactionNotifier());
