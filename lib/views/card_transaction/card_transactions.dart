import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/core/model/card_model.dart';
import 'package:mintyn_bank/views/card/card_carousel.dart';
import 'package:mintyn_bank/views/card_transaction/widget/spend_chart.dart';
import 'package:mintyn_bank/views/homepage/provider/transaction_provider.dart';

class CardTransactions extends StatefulWidget {
  final CardModel card;

  const CardTransactions({super.key, required this.card});

  @override
  State<CardTransactions> createState() => _CardTransactionsState();
}

class _CardTransactionsState extends State<CardTransactions> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<TransactionProvider>();
      if (provider.state == ViewState.idle) {
        provider.load();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Card Transaction',
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(height: 190, child: CardFace(card: widget.card)),
                    const SizedBox(height: 20),
                    const SpendChartCard(),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Transaction History',
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Consumer<TransactionProvider>(
                      builder: (context, provider, _) {
                        if (provider.isLoading) {
                          return const Padding(
                            padding: EdgeInsets.symmetric(vertical: 30),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                        if (provider.hasError) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              children: [
                                Text(
                                  provider.errorMessage ??
                                      'Something went wrong',
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: provider.load,
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          );
                        }

                        final cardTransactions = provider.transactionsForCard(
                          widget.card.id,
                        );

                        if (cardTransactions.isEmpty) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: Center(
                              child: Text(
                                'No transactions on this card yet',
                                style: TextStyle(color: AppColors.textGrey),
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemBuilder: (context, index) {
                            final txn = cardTransactions[index];
                            final isCredit = txn.amount >= 0;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 13),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        child: Icon(txn.icon),
                                      ),
                                      const SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            txn.title,
                                            style: const TextStyle(
                                              fontSize: 17,
                                              letterSpacing: 0.4,
                                            ),
                                          ),
                                          Text(
                                            DateFormat(
                                              'h:mm a  dd-MM-yyyy',
                                            ).format(txn.time),
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
                                    '${isCredit ? '+' : ''}${txn.amount.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: isCredit
                                          ? Colors.blue
                                          : Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: cardTransactions.length,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
