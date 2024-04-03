import 'package:flutter/services.dart';

class TransactionAPIService {
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 1));

    final String response = await rootBundle.loadString('assets/payments.json');
    return response;
  }
}
