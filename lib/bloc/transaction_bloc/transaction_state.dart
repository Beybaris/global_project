import 'package:global_project/model/transaction.dart';

abstract class TransactionState {}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionSuccessState extends TransactionState {
  final List<Transaction> transactions;

  TransactionSuccessState(this.transactions);
}

class TransactionErrorState extends TransactionState {
  final String error;
  TransactionErrorState(this.error);
}
