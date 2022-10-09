import 'package:hive/hive.dart';

import '../../../domain_layer/domain_exception.dart';
import '../../../domain_layer/models/transaction_aggregate/transaction.dart';
import '../../interfaces/i_transaction_repository.dart';

class TransactionRepository implements ITransactionRepository {
  late final String boxName;

  TransactionRepository(this.boxName);

  // トランザクションの追加
  @override
  Future<void> addTransaction(Transaction transaction) async {
    final Box<Transaction> box = await Hive.openBox<Transaction>(boxName);
    try {
      await box.add(transaction);
    } on HiveError catch (e) {
      throw DomainException(e.message);
    }
  }

  // トランザクションの削除
  @override
  Future<void> deleteTransaction(Transaction transaction) async {
    final Box<Transaction> box = await Hive.openBox<Transaction>(boxName);
    try {
      await box.delete(_findIndex(transaction));
    } on HiveError catch (e) {
      throw DomainException(e.message);
    }
  }

  // トランザクションの更新
  @override
  Future<void> updateTransaction(Transaction transaction) async {
    final Box<Transaction> box = await Hive.openBox<Transaction>(boxName);
    try {
      await box.putAt(_findIndex(transaction), transaction);
    } on HiveError catch (e) {
      throw DomainException(e.message);
    }
  }

  @override
  Future<Transaction> find(String id) async {
    final Box<Transaction> box = await Hive.openBox<Transaction>(boxName);
    try {
      var transaction = box.values
          .firstWhere((Transaction transaction) => transaction.id == id);
      return _clone(transaction);
    } on HiveError catch (e) {
      throw DomainException(e.message);
    }
  }

  Transaction _clone(Transaction transaction) {
    return Transaction(
      id: transaction.id,
      title: transaction.title,
      amount: transaction.amount,
      date: transaction.date,
    );
  }

  // Boxの中からトランザクションのIndexを探す
  int _findIndex(Transaction transaction) {
    final Box<Transaction> box = Hive.box<Transaction>(boxName);
    final int index = box.values.toList().indexOf(transaction);
    return index;
  }
}
