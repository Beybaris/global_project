abstract class TransactionState {}

class TransactionInitialState extends TransactionState {}

class TransactionLoadingState extends TransactionState {}

class TransactionSuccessState extends TransactionState {
  final String message;

  TransactionSuccessState(this.message);
}

class TransactionErrorState extends TransactionState {
  final String error;
  TransactionErrorState(this.error);
}
