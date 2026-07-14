import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/views/card/credit_card.dart';
import 'package:mintyn_bank/views/profile/profile.dart';
import 'package:mintyn_bank/views/shared_widgets/profile_tile.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      },
                      child: Stack(
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile Settings',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    ProfileTile(
                      title: 'E-statement',
                      asset: 'assets/icons/e-statement.svg',
                    ),
                    SizedBox(height: 17),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CreditCard()),
                        );
                      },
                      child: ProfileTile(
                        title: 'Credit Card',
                        asset: 'assets/icons/cc.svg',
                      ),
                    ),
                    SizedBox(height: 17),
                    ProfileTile(
                      title: 'Settings',
                      asset: 'assets/icons/settings.svg',
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Notification',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    ProfileTile(
                      title: 'App Notification',
                      asset: 'assets/icons/notification.svg',
                      switchValue: _notificationsEnabled,
                      onSwitchChanged: (v) =>
                          setState(() => _notificationsEnabled = v),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'More',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(height: 15),
                    ProfileTile(
                      title: 'Language',
                      asset: 'assets/icons/translate.svg',
                    ),
                    SizedBox(height: 17),
                    ProfileTile(
                      title: 'Country',
                      asset: 'assets/icons/globe.svg',
                    ),
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
      ),
    );
  }
}
