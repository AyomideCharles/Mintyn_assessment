import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/core/model/transaction_model.dart';

enum TxnFilter { weekly, monthly, today }

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  TxnFilter _selectedFilter = TxnFilter.today;

  List<TransactionModel> get _filteredTransactions {
    final now = DateTime.now();
    return dummyTransactions.where((txn) {
      final diff = now.difference(txn.time).inDays;
      switch (_selectedFilter) {
        case TxnFilter.today:
          return diff == 0;
        case TxnFilter.weekly:
          return diff <= 7;
        case TxnFilter.monthly:
          return diff <= 30;
      }
    }).toList();
  }

  Widget buildChip(String label, TxnFilter filter) {
    final isSelected = _selectedFilter == filter;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => setState(() => _selectedFilter = filter),
      showCheckmark: false,
      backgroundColor: const Color(0xFF232325),
      selectedColor: AppColors.lightBlue,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : AppColors.textGrey,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
        fontSize: 13,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    final transactions = _filteredTransactions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 10,
          children: [
            buildChip('Today', TxnFilter.today),
            buildChip('Weekly', TxnFilter.weekly),
            buildChip('Monthly', TxnFilter.monthly),
          ],
        ),
        SizedBox(height: 20),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeOut,
          switchOutCurve: Curves.easeIn,
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: transactions.isEmpty
              ? Padding(
                  key: const ValueKey('empty'),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                    child: Text(
                      'No transactions in this period',
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                  ),
                )
              : ListView.separated(
                  key: ValueKey(_selectedFilter),
                  primary: false,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return AnimatedTransactionTile(
                      transaction: transactions[index],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: transactions.length,
                ),
        ),
      ],
    );
  }
}

class AnimatedTransactionTile extends StatefulWidget {
  final TransactionModel transaction;
  final int index;

  const AnimatedTransactionTile({
    super.key,
    required this.transaction,
    required this.index,
  });

  @override
  State<AnimatedTransactionTile> createState() =>
      AnimatedTransactionTileState();
}

class AnimatedTransactionTileState extends State<AnimatedTransactionTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 350),
  );

  @override
  void initState() {
    super.initState();
    final delay = Duration(milliseconds: 40 * widget.index.clamp(0, 10));
    Future.delayed(delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final isCredit = transaction.amount >= 0;

    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.15),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(transaction.icon),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: TextStyle(fontSize: 17, letterSpacing: 0.4),
                      ),
                      Text(
                        DateFormat(
                          'h:mm a  dd-MM-yyyy',
                        ).format(transaction.time),
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                '${isCredit ? '+' : ''}${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: isCredit ? Colors.blue : Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
