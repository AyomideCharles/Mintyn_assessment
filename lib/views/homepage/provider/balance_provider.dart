import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mintyn_bank/core/model/transaction_model.dart';
import 'package:mintyn_bank/core/services/realtime_services.dart';

class BalanceProvider extends ChangeNotifier {
  final RealtimeService _realtime;
  BalanceProvider(this._realtime, {this.initialBalance = 1200});

  final double initialBalance;
  late double _balance = initialBalance;
  ConnectionStatus _connectionStatus = ConnectionStatus.disconnected;

  StreamSubscription<TransactionModel>? _txnSub;
  StreamSubscription<ConnectionStatus>? _statusSub;

  double get balance => _balance;
  ConnectionStatus get connectionStatus => _connectionStatus;
  bool get isLive => _connectionStatus == ConnectionStatus.connected;

  void start() {
    _statusSub ??= _realtime.statusStream.listen((status) {
      _connectionStatus = status;
      notifyListeners();
    });

    _txnSub ??= _realtime.transactionStream.listen((txn) {
      _balance += txn.amount;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _txnSub?.cancel();
    _statusSub?.cancel();
    super.dispose();
  }
}
