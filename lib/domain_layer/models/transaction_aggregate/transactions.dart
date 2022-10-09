import 'package:account_book_app/domain_layer/models/transaction_aggregate/transaction.dart';

class Transactions {
  final List<Transaction> transactions;

  Transactions(this.transactions);

  List<Transaction> get getTransactions {
    return transactions;
  }

  List<Transaction> get sortAmountAscendingList {
    final List<Transaction> amountAscendingList = transactions;
    amountAscendingList.sort((a, b) => a.amount.compareTo(b.amount));
    return amountAscendingList;
  }

  List<Transaction> get sortAmountDescendingList {
    return sortAmountAscendingList.reversed.toList();
  }

  List<Transaction> get sortDateAscendingList {
    final List<Transaction> sortDateAscendingList = transactions;
    sortDateAscendingList.sort((a, b) => a.date.compareTo(b.date));
    return sortDateAscendingList;
  }

  List<Transaction> get sortDateDescendingList {
    return sortDateAscendingList.reversed.toList();
  }

  int getTransactionIndex(Transaction transaction) {
    return transactions.indexOf(transaction);
  }
}
