import 'package:flutter/material.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';

class ConnectionBanner extends StatelessWidget {
  final bool reconnecting;

  const ConnectionBanner({super.key, this.reconnecting = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 12,
            height: 12,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.orange,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            reconnecting ? 'Reconnecting…' : 'Connection lost',
            style: const TextStyle(fontSize: 12, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
