import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/views/card/card_carousel.dart';

enum CardType { physical, virtual }

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  CardType _selectedType = CardType.physical;
  final PageController _pageController = PageController(viewportFraction: 0.78);
  int _currentPage = 0;
  bool _revealed = false;

  final Map<String, bool> _settings = {
    'Change Pin': true,
    'QR Payment': true,
    'Online Shopping': false,
    'Tap Pay': true,
  };

  static const Color _accentBlue = Color(0xFF0047B3);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Card',
                          style: TextStyle(
                            letterSpacing: 0.4,
                            fontWeight: FontWeight.w700,
                            fontSize: 28,
                          ),
                        ),
                        Icon(Icons.more_horiz),
                      ],
                    ),
                    Text(
                      '2 Physical Card, 1 Virtual Card',
                      style: TextStyle(color: AppColors.textGrey, fontSize: 12),
                    ),
                    SizedBox(height: 15),
                    CardTypeToggle(
                      selected: _selectedType,
                      onChanged: (type) => setState(() => _selectedType = type),
                      accentColor: _accentBlue,
                    ),
                    const SizedBox(height: 20),
                    CardCarousel(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                          icon: Icons.ac_unit_rounded,
                          label: 'Freeze Card',
                          onTap: () {},
                        ),
                        ActionButton(
                          icon: _revealed
                              ? Icons.visibility_rounded
                              : Icons.visibility_off_rounded,
                          label: 'Reveal',
                          onTap: () => setState(() => _revealed = !_revealed),
                        ),
                        ActionButton(
                          icon: Icons.ac_unit_rounded,
                          label: 'Freeze Card',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Card Settings',
                      style: TextStyle(
                        letterSpacing: 0.4,
                        fontWeight: FontWeight.w400,
                        fontSize: 28,
                      ),
                    ),
                    SizedBox(height: 12),
                    SettingsRow(
                      asset: 'assets/icons/password.svg',
                      label: 'Change Pin',
                      value: _settings['Change Pin']!,
                      accentColor: _accentBlue,
                      onChanged: (v) =>
                          setState(() => _settings['Change Pin'] = v),
                    ),
                    SizedBox(height: 19),
                    SettingsRow(
                      asset: 'assets/icons/qr.svg',
                      label: 'QR Payment',
                      value: _settings['QR Payment']!,
                      accentColor: _accentBlue,
                      onChanged: (v) =>
                          setState(() => _settings['QR Payment'] = v),
                    ),
                    SizedBox(height: 19),
                    SettingsRow(
                      asset: 'assets/icons/house.svg',
                      label: 'Online Shopping',
                      value: _settings['Online Shopping']!,
                      accentColor: _accentBlue,
                      onChanged: (v) =>
                          setState(() => _settings['Online Shopping'] = v),
                    ),
                    SizedBox(height: 19),
                    SettingsRow(
                      asset: 'assets/icons/card.svg',
                      label: 'Card Transactions',
                      trailing: const Icon(
                        Icons.chevron_right_rounded,
                        color: Colors.white54,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 19),
                    SettingsRow(
                      asset: 'assets/icons/internet.svg',
                      label: 'Tap Pay',
                      value: _settings['Tap Pay']!,
                      accentColor: _accentBlue,
                      onChanged: (v) =>
                          setState(() => _settings['Tap Pay'] = v),
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

class ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: const BoxDecoration(
              color: Color(0xFF232325),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 22),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class CardTypeToggle extends StatelessWidget {
  final CardType selected;
  final ValueChanged<CardType> onChanged;
  final Color accentColor;

  const CardTypeToggle({
    super.key,
    required this.selected,
    required this.onChanged,
    required this.accentColor,
  });

  Widget _chip(String label, CardType type) {
    final isSelected = selected == type;
    return GestureDetector(
      onTap: () => onChanged(type),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: isSelected ? accentColor : Colors.white24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white38,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _chip('Physical Card', CardType.physical),
        const SizedBox(width: 12),
        _chip('Virtual Card', CardType.virtual),
      ],
    );
  }
}

class SettingsRow extends StatelessWidget {
  final String asset;
  final String label;
  final bool? value;
  final ValueChanged<bool>? onChanged;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? accentColor;

  const SettingsRow({
    super.key,
    required this.asset,
    required this.label,
    this.value,
    this.onChanged,
    this.trailing,
    this.onTap,
    this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final content = Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.grey1,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: SvgPicture.asset(asset, fit: BoxFit.contain),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          if (value != null)
            Switch(
              value: value!,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: accentColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.white24,
            )
          else if (trailing != null)
            SizedBox(height: 24, child: Center(child: trailing!)),
        ],
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: content,
      );
    }
    return content;
  }
}
