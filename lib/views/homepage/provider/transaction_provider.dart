import 'package:flutter/material.dart';
import 'package:mintyn_bank/core/model/transaction_model.dart';
import 'package:mintyn_bank/core/services/transaction_mock_service.dart';

enum ViewState { idle, loading, loaded, error }

enum TxnFilter { today, weekly, monthly }

class TransactionProvider extends ChangeNotifier {
  final MockTransactionService _service;
  TransactionProvider(this._service);

  ViewState _state = ViewState.idle;
  List<TransactionModel> _all = [];
  String? _errorMessage;
  TxnFilter _filter = TxnFilter.today;

  ViewState get state => _state;
  bool get isLoading => _state == ViewState.loading;
  bool get hasError => _state == ViewState.error;
  String? get errorMessage => _errorMessage;
  TxnFilter get filter => _filter;

  List<TransactionModel> get transactions {
    final now = DateTime.now();
    final filtered = _all.where((txn) {
      final diff = now.difference(txn.time).inDays;
      switch (_filter) {
        case TxnFilter.today:
          return diff == 0;
        case TxnFilter.weekly:
          return diff <= 7;
        case TxnFilter.monthly:
          return diff <= 30;
      }
    }).toList();
    return filtered..sort((a, b) => b.time.compareTo(a.time));
  }

  Future<void> load() async {
    _state = ViewState.loading;
    _errorMessage = null;
    notifyListeners();
    try {
      _all = await _service.fetchTransactions();
      _state = ViewState.loaded;
    } catch (e) {
      _errorMessage = 'Failed to load transactions. Please try again.';
      _state = ViewState.error;
    }
    notifyListeners();
  }

  void setFilter(TxnFilter filter) {
    if (_filter == filter) return;
    _filter = filter;
    notifyListeners();
  }

  // this is to get transactions by each card
  List<TransactionModel> transactionsForCard(String cardId) {
    final filtered = _all.where((t) => t.cardId == cardId).toList()
      ..sort((a, b) => b.time.compareTo(a.time));
    return filtered;
  }
}
