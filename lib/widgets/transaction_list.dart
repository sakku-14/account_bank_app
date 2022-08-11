import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  final bool isLandscape;

  TransactionList(this.transactions, this.deleteTransaction, this.isLandscape);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                const Text('No Transaction'),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
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
            },
            itemCount: transactions.length,
          );
  }
}
