import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';
import 'package:account_book_app/view_model_layer/transaction_list/transaction_list_notifier.dart';
import 'package:account_book_app/view_model_layer/transaction_list/transaction_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../domain_layer/models/transaction_aggregate/transactions.dart';

class TransactionList extends ConsumerWidget {
  final Transactions transactions;

  TransactionList(this.transactions, {Key? key}) : super(key: key) {}

  // 個別のトランザクション
  Widget eachTransaction(int index, Transactions transactions,
      Function getShowAmount, Function deleteTransaction) {
    var showList = transactions.sortDateAscendingList;
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(getShowAmount(showList[index].amount)),
            ),
          ),
        ),
        title: Text(showList[index].title),
        subtitle: Text(
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
  Widget build(BuildContext context, WidgetRef ref) {
    // state
    final TransactionListState transactionListState =
        ref.watch(transactionListProvider);
    // notifier
    final TransactionListNotifier transactionListNotifier =
        ref.watch(transactionListProvider.notifier);

    return FutureBuilder<Iterable<Transaction>>(
      future: transactionListState.transactionRepository.findAll(),
      builder: (BuildContext context,
          AsyncSnapshot<Iterable<Transaction>> snapshot) {
        return snapshot.data == null ||
                Transactions(snapshot.data!.toList()).getTransactions.isEmpty
            ? LayoutBuilder(builder: (context, constraints) {
                return showEmpty(constraints);
              })
            : ListView.builder(
                padding: const EdgeInsets.all(0),
                itemBuilder: (context, index) {
                  return eachTransaction(
                    index,
                    Transactions(snapshot.data!.toList()),
                    transactionListNotifier.getShowAmount,
                    transactionListNotifier.deleteTransaction,
                  );
                },
                itemCount: Transactions(snapshot.data!.toList())
                    .getTransactions
                    .length,
              );
      },
    );
  }
}
