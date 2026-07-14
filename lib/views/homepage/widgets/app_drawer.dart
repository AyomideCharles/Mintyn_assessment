import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/views/card/credit_card.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _notificationsEnabled = true;

  Widget profileContainer(
    String title,
    String asset, {
    bool? switchValue,
    ValueChanged<bool>? onSwitchChanged,
  }) {
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
          Expanded(child: Text(title, style: TextStyle(fontSize: 15))),
          if (switchValue != null)
            Switch(
              value: switchValue,
              onChanged: onSwitchChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: AppColors.darkBlue,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.white24,
            )
          else
            const Icon(Icons.chevron_right_rounded, size: 30),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'assets/images/pic.jpg',
                          width: 59,
                          height: 59,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SvgPicture.asset('assets/icons/edit.svg'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Welcome',
                    style: TextStyle(fontSize: 12, letterSpacing: 0.4),
                  ),
                  Text(
                    'Tayyab Sohali',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
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
                    switchValue: _notificationsEnabled,
                    onSwitchChanged: (v) =>
                        setState(() => _notificationsEnabled = v),
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
                  SizedBox(height: 30),
                  Container(
                    width: 108,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFD4D4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF5A0000),
                          ),
                        ),
                        SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/icons/Log_Out.svg',
                          color: Color(0xFF5A0000),
                        ),
                      ],
                    ),
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
