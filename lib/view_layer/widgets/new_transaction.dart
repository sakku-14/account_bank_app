import 'package:account_book_app/view_model_layer/new_transaction/new_transaction_notifier.dart';
import 'package:account_book_app/view_model_layer/new_transaction/new_transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class NewTransaction extends ConsumerStatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx, {Key? key}) : super(key: key);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends ConsumerState<NewTransaction> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // state
    final NewTransactionState newTransactionState =
        ref.watch(newTransactionProvider);
    // notifier
    final NewTransactionNotifier newTransactionNotifier =
        ref.watch(newTransactionProvider.notifier);

    // 商品名入力欄
    final itemTitle = SizedBox(
      height: 60,
      child: KeyboardActions(
        config: newTransactionNotifier.buildConfig(),
        child: TextField(
          focusNode: newTransactionState.nodeTitle,
          decoration: const InputDecoration(labelText: 'タイトル'),
          controller: newTransactionState.titleController,
          onSubmitted: (_) =>
              newTransactionNotifier.submitData(widget.addTx, context),
        ),
      ),
    );

    // 商品金額入力欄
    final itemAmount = SizedBox(
      height: 60,
      child: KeyboardActions(
        config: newTransactionNotifier.buildConfig(),
        child: TextField(
          focusNode: newTransactionState.nodeAmount,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: '金額'),
          controller: newTransactionState.amountController,
          onSubmitted: (_) =>
              newTransactionNotifier.submitData(widget.addTx, context),
        ),
      ),
    );

    // 日付選択ボタン
    final purchaseDate = SizedBox(
      height: 50,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
                '日付: ${DateFormat.yMd('ja').format(newTransactionState.selectedDate)}'),
          ),
          TextButton(
            onPressed: () => newTransactionNotifier.presentDatePicker(context),
            child: const Text(
              '日付を選択',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    // 登録ボタン
    final registerButton = ElevatedButton(
      onPressed: () => newTransactionNotifier.submitData(widget.addTx, context),
      child: const Text('追加'),
    );

    return Card(
      elevation: 5,
      child: SizedBox(
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            itemTitle,
            itemAmount,
            purchaseDate,
            registerButton,
          ],
        ),
      ),
    );
  }
}
