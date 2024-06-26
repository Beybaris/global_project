import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_project/bloc/transaction_bloc/transaction_event.dart';
import 'package:global_project/bloc/transaction_bloc/transaction_state.dart';
import 'package:global_project/model/transaction.dart';
import 'package:global_project/service/TransactionAPIService.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionAPIService transactionAPIService;

  TransactionBloc(this.transactionAPIService)
      : super(TransactionInitialState()) {
    on<TransactionLoadEvent>((event, emit) async {
      emit(TransactionLoadingState());

      try {
        final data = await transactionAPIService.fetchData();
        final jsonData = json.decode(data) as List;
        final transactions =
            jsonData.map((jsonItem) => Transaction.fromJson(jsonItem)).toList();
        emit(TransactionSuccessState(transactions));
      } catch (e) {
        emit(TransactionErrorState(e.toString()));
      }
    });
  }
}
