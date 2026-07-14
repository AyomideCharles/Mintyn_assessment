import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/core/model/transaction_model.dart';

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
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppColors.grey1,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(transaction.icon),
                  ),
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