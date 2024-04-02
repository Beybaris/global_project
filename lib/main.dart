import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_project/bloc/transaction_bloc.dart';
import 'package:global_project/bloc/transaction_event.dart';
import 'package:global_project/bloc/transaction_state.dart';
import 'package:global_project/service/TransactionAPIService.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final mockApiService = TransactionAPIService(); // Create an instance of the mock API service

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => TransactionBloc(mockApiService),
        child: Scaffold(
          appBar: AppBar(
            title: Text('BLoC with Mock API'),
          ),
          body: Center(
            child: MockAPIFetchWidget(),
          ),
        ),
      ),
    );
  }
}

class MockAPIFetchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the BLoC
    final bloc = BlocProvider.of<TransactionBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              return CircularProgressIndicator();
            } else if (state is TransactionSuccessState) {
              return Text(state.message);
            } else if (state is TransactionErrorState) {
              return Text('Error: ${state.error}');
            }
            return ElevatedButton(
              onPressed: () => bloc.add(TransactionLoadEvent()),
              child: Text('Fetch Data'),
            );
          },
        ),
      ],
    );
  }
}