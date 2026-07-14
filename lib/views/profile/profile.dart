import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/views/shared_widgets/header_text.dart';
import 'package:mintyn_bank/views/shared_widgets/profile_tile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
  bool _notificationsEnabled = true;

  late final AnimationController animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
  )..forward();

  Animation<double> fadeFor(double start, double end) {
    return CurvedAnimation(
      parent: animationController,
      curve: Interval(start, end, curve: Curves.easeOut),
    );
  }

  Widget animatedSection(double start, double end, Widget child) {
    final fade = fadeFor(start, end);
    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.06),
          end: Offset.zero,
        ).animate(fade),
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                animatedSection(
                  0.0,
                  0.4,
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.navigate_before, size: 35),
                      ),
                      SizedBox(width: 10),
                      const HeaderText('Profile'),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                animatedSection(
                  0.05,
                  0.45,
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(52),
                        child: Image.asset(
                          'assets/images/pic.jpg',
                          width: 52,
                          height: 52,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Tayyab Sohali',
                                style: TextStyle(fontSize: 15),
                              ),
                              const SizedBox(width: 11),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.grey1,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: const Text(
                                  'UX/UI Designer',
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'tayyabsohailabd@gmail.com',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Divider(height: 40),
                animatedSection(
                  0.15,
                  0.55,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderText('Profile Settings', fontSize: 20),
                      const SizedBox(height: 15),
                      const ProfileTile(
                        title: 'E-statement',
                        asset: 'assets/icons/e-statement.svg',
                      ),
                      const SizedBox(height: 17),
                      const ProfileTile(
                        title: 'Credit Card',
                        asset: 'assets/icons/cc.svg',
                      ),
                      const SizedBox(height: 17),
                      const ProfileTile(
                        title: 'Settings',
                        asset: 'assets/icons/settings.svg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                animatedSection(
                  0.3,
                  0.7,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderText('Notification', fontSize: 20),
                      const SizedBox(height: 15),
                      ProfileTile(
                        title: 'App Notification',
                        asset: 'assets/icons/notification.svg',
                        switchValue: _notificationsEnabled,
                        onSwitchChanged: (v) =>
                            setState(() => _notificationsEnabled = v),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                animatedSection(
                  0.45,
                  0.85,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderText('More', fontSize: 20),
                      const SizedBox(height: 15),
                      const ProfileTile(
                        title: 'Language',
                        asset: 'assets/icons/translate.svg',
                      ),
                      const SizedBox(height: 17),
                      const ProfileTile(
                        title: 'Country',
                        asset: 'assets/icons/globe.svg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                animatedSection(
                  0.6,
                  1.0,
                  Container(
                    width: 108,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD4D4),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF5A0000),
                          ),
                        ),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          'assets/icons/Log_Out.svg',
                          color: const Color(0xFF5A0000),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
