import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final String asset;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final VoidCallback? onTap;

  const ProfileTile({
    super.key,
    required this.title,
    required this.asset,
    this.switchValue,
    this.onSwitchChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      width: double.infinity,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.grey2,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey1,
            ),
            child: SvgPicture.asset(asset, width: 40, height: 40),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 15))),
          if (switchValue != null)
            Switch(
              value: switchValue!,
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

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: content);
    }
    return content;
  }
}
