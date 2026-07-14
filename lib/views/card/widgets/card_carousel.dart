import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mintyn_bank/core/constants/app_colors.dart';
import 'package:mintyn_bank/core/model/card_model.dart';

class CardCarousel extends StatefulWidget {
  final List<CardModel> cards;
  final ValueChanged<CardModel>? onCardTap;
  final ValueChanged<CardModel>? onPageChanged;

  const CardCarousel({
    super.key,
    required this.cards,
    this.onCardTap,
    this.onPageChanged,
  });

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.80);
  int _currentPage = 0;

  static const Color _accentBlue = Color(0xFF2F6FED);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.cards.length,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              widget.onPageChanged?.call(widget.cards[index]);
            },
            itemBuilder: (context, index) {
              final card = widget.cards[index];
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double page = _currentPage.toDouble();
                  if (_pageController.position.haveDimensions) {
                    page = _pageController.page ?? page;
                  }
                  final delta = (page - index);
                  final distance = delta.abs().clamp(0.0, 1);
                  final scale = 1 - (distance * 0.1);

                  return Center(
                    child: Transform.scale(scale: scale, child: child),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: GestureDetector(
                    onTap: () => widget.onCardTap?.call(card),
                    child: CardFace(card: card),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.cards.length, (index) {
            final isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: isActive ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: isActive ? _accentBlue : Colors.white24,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class CardFace extends StatelessWidget {
  final CardModel card;

  const CardFace({super.key, required this.card});

  Widget cardDetails(String detail, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail,
            style: TextStyle(fontSize: 11, color: AppColors.textGrey),
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 13),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5E4E4), width: 0.5),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/card_background.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: SvgPicture.asset('assets/icons/mastercard.svg'),
                ),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/chip.svg'),
                    const SizedBox(width: 20),
                    SvgPicture.asset('assets/icons/internet.svg'),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  '●●●● ●●●● ●●●●  ${card.last4}',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    cardDetails('Card Holder', card.holderName),
                    const SizedBox(width: 12),
                    cardDetails('Valid', card.expiryDate),
                    const SizedBox(width: 12),
                    cardDetails('CVV', card.cvv),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
