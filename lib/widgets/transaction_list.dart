import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  final bool isLandscape;

  const TransactionList(
      this.transactions, this.deleteTransaction, this.isLandscape);

  // 個別のトランザクション
  Widget eachTransaction(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
              padding: const EdgeInsets.all(6),
              child: FittedBox(
                child: Text(transactions[index].amount.toString()),
              )),
        ),
        title: Text(transactions[index].title),
        subtitle: Text(
          DateFormat.yMMMd().format(transactions[index].date),
        ),
        trailing: IconButton(
          onPressed: () => deleteTransaction(transactions[index].id),
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }

  // トランザクションが空の時の表示
  Widget showEmpty(BoxConstraints constraints) {
    return Column(
      children: <Widget>[
        const Text(
          'No Transaction',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 20,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: constraints.maxHeight * 0.6,
          child: Image.asset(
            'assets/images/waiting.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return showEmpty(constraints);
          })
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return eachTransaction(index);
            },
            itemCount: transactions.length,
          );
  }
}
