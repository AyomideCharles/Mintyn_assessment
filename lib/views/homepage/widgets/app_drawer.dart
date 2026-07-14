import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/views/card/credit_card.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  Widget profileContainer(String title, String asset) {
    return Container(
      width: double.infinity,
      height: 56,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey1,
            ),
            child: SvgPicture.asset(asset, width: 40, height: 40),
          ),
          SizedBox(width: 8),
          Expanded(child: Text(title, style: TextStyle(fontSize: 17))),
          const Icon(Icons.chevron_right_rounded, size: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF1C1C1D),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(),
                  SizedBox(height: 8),
                  Text('Welcome', style: TextStyle(fontSize: 12)),
                  Text('Tayyab Sohali'),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Profile Settings',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  profileContainer(
                    'E-statement',
                    'assets/icons/e-statement.svg',
                  ),
                  SizedBox(height: 17),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CreditCard()),
                      );
                    },
                    child: profileContainer(
                      'Credit Card',
                      'assets/icons/cc.svg',
                    ),
                  ),
                  SizedBox(height: 17),
                  profileContainer('Settings', 'assets/icons/settings.svg'),
                  SizedBox(height: 30),
                  Text(
                    'Notification',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  profileContainer(
                    'App Notification',
                    'assets/icons/notification.svg',
                  ),
                  SizedBox(height: 30),
                  Text(
                    'More',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  SizedBox(height: 15),
                  profileContainer('Language', 'assets/icons/translate.svg'),
                  SizedBox(height: 17),
                  profileContainer('Country', 'assets/icons/globe.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
