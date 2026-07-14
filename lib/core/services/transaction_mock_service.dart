import 'package:mintyn_bank/core/model/transaction_model.dart';

class MockTransactionService {
  Future<List<TransactionModel>> fetchTransactions() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.unmodifiable(dummyTransactions);
  }
}
