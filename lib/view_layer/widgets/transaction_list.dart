import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain_layer/models/transaction_aggregate/transaction.dart';
import '../../domain_layer/models/transaction_aggregate/transactions.dart';

class TransactionList extends StatelessWidget {
  // final List<Transaction> transactions;
  late Transactions transactions;
  late Function deleteTransaction;
  late bool isLandscape;

  TransactionList(List<Transaction> transactions, this.deleteTransaction,
      this.isLandscape) {
    this.transactions = Transactions(transactions);
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

  // 個別のトランザクション
  Widget eachTransaction(int index) {
    var showList = transactions.sortDateAscendingList;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              // child: Text(getShowAmount(transactions[index].amount)),
              child: Text(getShowAmount(showList[index].amount)),
            ),
          ),
        ),
        // title: Text(transactions[index].title),
        title: Text(showList[index].title),
        subtitle: Text(
          // DateFormat.yMMMd('ja').format(transactions[index].date),
          DateFormat.yMMMd('ja').format(showList[index].date),
        ),
        trailing: IconButton(
          onPressed: () => deleteTransaction(showList[index]),
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
    return transactions.getTransactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return showEmpty(constraints);
          })
        : ListView.builder(
            padding: const EdgeInsets.all(0),
            itemBuilder: (context, index) {
              return eachTransaction(index);
            },
            itemCount: transactions.getTransactions.length,
          );
  }
}
