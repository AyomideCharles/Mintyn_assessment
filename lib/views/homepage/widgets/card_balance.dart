import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';

class CardBalance extends StatelessWidget {
  const CardBalance({super.key});

  Widget cardButton(IconData icons, String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(4),
      ),
      width: 151,
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icons, color: AppColors.whiteColor),
          SizedBox(width: 10),
          Text(
            label,
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 236,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFE5E4E4), width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/card_background.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset("assets/icons/masterCard.png"),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Balance',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            '\$ 1200',
                            style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 34,
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset(
                        'assets/images/qr_code.svg',
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      cardButton(Icons.add, 'Add Cash'),
                      cardButton(Icons.outbond, 'Send Money'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
