import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mintyn_bank/core/model/transaction_model.dart';

enum ConnectionStatus { connecting, connected, disconnected, reconnecting }

class RealtimeService {
  final _random = Random();

  final _statusController = StreamController<ConnectionStatus>.broadcast();
  final _transactionController = StreamController<TransactionModel>.broadcast();

  Timer? _transactionTimer;
  Timer? _reconnectTimer;
  ConnectionStatus _status = ConnectionStatus.disconnected;
  bool _isDisposed = false;

  Stream<ConnectionStatus> get statusStream => _statusController.stream;
  Stream<TransactionModel> get transactionStream =>
      _transactionController.stream;

  ConnectionStatus get status => _status;

  static const List<String> merchants = [
    "PSN",
    'Xbox',
    'Spotify',
    'Apple Store',
    'McDonalds',
  ];

  void connect() {
    _setStatus(ConnectionStatus.connecting);
    Future.delayed(const Duration(milliseconds: 600), () {
      if (_isDisposed) return;
      _setStatus(ConnectionStatus.connected);
      _startTicking();
    });
  }

  void _startTicking() {
    _transactionTimer?.cancel();

    _transactionTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (_random.nextDouble() < 0.1 && _status == ConnectionStatus.connected) {
        _simulateDrop();
        return;
      }
      if (_status != ConnectionStatus.connected) return;
      _transactionController.add(_randomTransaction());
    });
  }

  TransactionModel _randomTransaction() {
    final merchant = merchants[_random.nextInt(merchants.length)];
    final isCredit = _random.nextDouble() < 0.25;
    final amount = 5 + _random.nextDouble() * 95;
    return TransactionModel(
      id: 'txn_${DateTime.now().microsecondsSinceEpoch}',
      cardId: 'card_1',
      icon: isCredit ? Icons.arrow_downward_rounded : Icons.bolt_rounded,
      title: merchant,
      time: DateTime.now(),
      amount: isCredit
          ? double.parse(amount.toStringAsFixed(2))
          : -double.parse(amount.toStringAsFixed(2)),
    );
  }

  void _simulateDrop() {
    _setStatus(ConnectionStatus.disconnected);
    _transactionTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      if (_isDisposed) return;
      _setStatus(ConnectionStatus.reconnecting);
      Future.delayed(const Duration(milliseconds: 900), () {
        if (_isDisposed) return;
        _setStatus(ConnectionStatus.connected);
        _startTicking();
      });
    });
  }

  void _setStatus(ConnectionStatus status) {
    _status = status;
    if (!_statusController.isClosed) _statusController.add(status);
  }

  void dispose() {
    _isDisposed = true;
    _transactionTimer?.cancel();
    _reconnectTimer?.cancel();
    _statusController.close();
    _transactionController.close();
  }
}
