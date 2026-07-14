import 'package:flutter/material.dart';
import 'package:mintyn_bank/core/services/realtime_services.dart';
import 'package:mintyn_bank/views/homepage/widgets/animated_tile.dart';
import 'package:mintyn_bank/views/shared_widgets/connection_banner.dart';
import 'package:mintyn_bank/views/shared_widgets/header_text.dart';
import 'package:provider/provider.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/core/model/card_model.dart';
import 'package:mintyn_bank/views/card/widgets/card_carousel.dart';
import 'package:mintyn_bank/views/card_transaction/widget/spend_chart.dart';
import 'package:mintyn_bank/views/homepage/provider/transaction_provider.dart';

class CardTransactions extends StatefulWidget {
  final CardModel card;

  const CardTransactions({super.key, required this.card});

  @override
  State<CardTransactions> createState() => _CardTransactionsState();
}

class _CardTransactionsState extends State<CardTransactions>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  )..forward();

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

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
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.navigate_before, size: 35),
                            ),
                            SizedBox(width: 10),
                            HeaderText('Card Transaction'),
                          ],
                        ),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Consumer<TransactionProvider>(
                      builder: (context, provider, _) {
                        final status = provider.connectionStatus;
                        if (status != ConnectionStatus.disconnected &&
                            status != ConnectionStatus.reconnecting) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ConnectionBanner(
                            reconnecting:
                                status == ConnectionStatus.reconnecting,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 190,
                      child: FadeTransition(
                        opacity: _entranceController,
                        child: ScaleTransition(
                          scale: Tween(begin: 0.75, end: 1.0).animate(
                            CurvedAnimation(
                              parent: _entranceController,
                              curve: Curves.easeOut,
                            ),
                          ),
                          child: CardFace(card: widget.card),
                        ),
                      ),
                    ),
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
                            return AnimatedTransactionTile(
                              transaction: cardTransactions[index],
                              index: index,
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
