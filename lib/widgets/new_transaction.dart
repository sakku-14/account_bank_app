import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    FocusScope.of(context).unfocus();
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  // Custom widget for TextField
  final FocusNode _nodeTitle = FocusNode();
  final FocusNode _nodeAmount = FocusNode();

  KeyboardActionsConfig _buildConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(focusNode: _nodeTitle, toolbarButtons: [
          // 完了ボタン
          (node) {
            return GestureDetector(
              onTap: () => node.unfocus(),
              child: const Text('完了'),
            );
          },
        ]),
        KeyboardActionsItem(focusNode: _nodeAmount, toolbarButtons: [
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

  @override
  Widget build(BuildContext context) {
    // 商品名入力欄
    final itemTitle = SizedBox(
      height: 60,
      child: KeyboardActions(
        config: _buildConfig(),
        child: TextField(
          focusNode: _nodeTitle,
          decoration: const InputDecoration(labelText: 'Title'),
          controller: _titleController,
          onSubmitted: (_) => _submitData(),
        ),
      ),
    );

    // 商品金額入力欄
    final itemAmount = SizedBox(
      height: 60,
      child: KeyboardActions(
        config: _buildConfig(),
        child: TextField(
          focusNode: _nodeAmount,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Amount'),
          controller: _amountController,
          onSubmitted: (_) => _submitData(),
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
              _selectedDate == null
                  ? 'No Date Chosen!'
                  : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
            ),
          ),
          TextButton(
            onPressed: _presentDatePicker,
            child: const Text(
              'Choose Date',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    // 登録ボタン
    final registerButton = ElevatedButton(
      onPressed: _submitData,
      child: const Text('Add Transaction'),
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
