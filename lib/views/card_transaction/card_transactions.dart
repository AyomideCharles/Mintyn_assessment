import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/views/card/card_carousel.dart';
import 'package:mintyn_bank/views/card_transaction/widget/spend_chart.dart';

class CardTransactions extends StatelessWidget {
  const CardTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                    SizedBox(height: 20),
                    SizedBox(height: 190, child: CardFace(color: Colors.black)),
                    SizedBox(height: 20),
                    SpendChartCard(),
                    // Container(
                    //   decoration: BoxDecoration(
                    //     border: Border.all(),
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   width: double.infinity,
                    //   height: 305,
                    // ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
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
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemBuilder: (context, index) {
                        return Padding(
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
                                    child: Icon(Icons.ios_share),
                                  ),
                                  SizedBox(width: 20),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'title',
                                        style: TextStyle(
                                          fontSize: 17,
                                          letterSpacing: 0.4,
                                        ),
                                      ),
                                      Text(
                                        DateFormat(
                                          'h:mm a  dd-MM-yyyy',
                                        ).format(DateTime.now()),
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
                                '100',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: 3,
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
