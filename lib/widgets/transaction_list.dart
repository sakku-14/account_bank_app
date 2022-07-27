import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: ListView.builder(
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
      ),
    );
  }
}
