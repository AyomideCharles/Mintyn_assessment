import 'package:flutter/material.dart';

class TransactionModel {
  final String id;
  final String cardId;
  final IconData icon;
  final String title;
  final DateTime time;
  final double amount;

  const TransactionModel({
    required this.id,
    required this.cardId,
    required this.icon,
    required this.title,
    required this.time,
    required this.amount,
  });
}

final List<TransactionModel> dummyTransactions = [
  TransactionModel(
    id: '1',
    cardId: 'card_1',
    icon: Icons.shopping_bag_rounded,
    title: 'E-Wallet',
    time: DateTime.now().subtract(const Duration(hours: 2)),
    amount: 100,
  ),
  TransactionModel(
    id: '2',
    cardId: 'card_1',
    icon: Icons.arrow_downward_rounded,
    title: 'Online Shopping',
    time: DateTime.now().subtract(const Duration(hours: 5)),
    amount: -100,
  ),
  TransactionModel(
    id: '3',
    cardId: 'card_2',
    icon: Icons.directions_car_rounded,
    title: 'E-Wallet',
    time: DateTime.now().subtract(const Duration(days: 1)),
    amount: 100,
  ),
  TransactionModel(
    id: '4',
    cardId: 'card_2',
    icon: Icons.movie_rounded,
    title: 'Netflix',
    time: DateTime.now().subtract(const Duration(days: 2)),
    amount: -15.99,
  ),
  TransactionModel(
    id: '5',
    cardId: 'card_3',
    icon: Icons.swap_horiz_rounded,
    title: 'Transfer to J. Lee',
    time: DateTime.now().subtract(const Duration(days: 4)),
    amount: -100.00,
  ),
  TransactionModel(
    id: '6',
    cardId: 'card_1',
    icon: Icons.laptop_mac_rounded,
    title: 'Freelance payment',
    time: DateTime.now().subtract(const Duration(days: 8)),
    amount: 400.00,
  ),
  TransactionModel(
    id: '7',
    cardId: 'card_2',
    icon: Icons.restaurant_rounded,
    title: 'Dinner',
    time: DateTime.now().subtract(const Duration(days: 15)),
    amount: -32.10,
  ),
  TransactionModel(
    id: '8',
    cardId: 'card_3',
    icon: Icons.receipt_long_rounded,
    title: 'Electricity Bill',
    time: DateTime.now().subtract(const Duration(days: 20)),
    amount: -60.00,
  ),
];
