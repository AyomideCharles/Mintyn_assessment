import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/views/homepage/provider/balance_provider.dart';
import 'package:mintyn_bank/views/homepage/widgets/card_balance.dart';
import 'package:mintyn_bank/views/homepage/widgets/app_drawer.dart';
import 'package:mintyn_bank/views/homepage/widgets/transaction_list.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                color: Color(0xFF272729),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        text: 'Welcome ',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                        ),
                        children: [
                          TextSpan(
                            text: 'Tayyab Sohali',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.notifications),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // CardBalance(),
                    Consumer<BalanceProvider>(
                      builder: (context, provider, _) {
                        return CardBalance(
                          balance: provider.balance,
                          isLive: provider.isLive,
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFF232325),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: QuickAction(
                              image: 'assets/icons/bill_pay.svg',
                              label: 'Bill Pay',
                            ),
                          ),
                          Container(
                            height: 36,
                            width: 1,
                            color: Colors.white24,
                          ),
                          Expanded(
                            child: QuickAction(
                              image: 'assets/icons/hand.svg',
                              label: 'Donation',
                            ),
                          ),
                          Container(
                            height: 36,
                            width: 1,
                            color: Colors.white24,
                          ),
                          Expanded(
                            child: QuickAction(
                              image: 'assets/icons/deposit.svg',
                              label: 'Deposit',
                            ),
                          ),
                          Container(
                            height: 36,
                            width: 1,
                            color: Colors.white24,
                          ),
                          Expanded(
                            child: QuickAction(
                              image: 'assets/icons/more.svg',
                              label: 'More',
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Transaction History',
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                            color: AppColors.lightBlue,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TransactionList(),
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

class QuickAction extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback? onTap;
  const QuickAction({
    super.key,
    required this.image,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Color(0xFF2C2C2C),
              shape: BoxShape.circle,
            ),
            child: FittedBox(
              fit: BoxFit.contain,
              child: SvgPicture.asset(image),
            ),
          ),
          SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
