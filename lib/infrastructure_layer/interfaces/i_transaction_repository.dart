import '../../domain_layer/models/transaction_aggregate/transaction.dart';

abstract class ITransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Future<void> deleteTransaction(Transaction transaction);
  Future<void> updateTransaction(Transaction transaction);
  Future<Transaction> find(String id);
}
