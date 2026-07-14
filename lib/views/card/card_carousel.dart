import 'package:flutter/material.dart';

class CardCarousel extends StatefulWidget {
  const CardCarousel({super.key});

  @override
  State<CardCarousel> createState() => _CardCarouselState();
}

class _CardCarouselState extends State<CardCarousel> {
  final PageController _pageController = PageController(viewportFraction: 0.6);
  int _currentPage = 0;

  static const Color _accentBlue = Color(0xFF2F6FED);

  final List<Color> _cardColors = const [
    Color(0xFFFFFFFF),
    Color(0xFF16324F),
    Color(0xFF1F3D2B),
  ];

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
          height: 190,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _cardColors.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double page = _currentPage.toDouble();
                  if (_pageController.position.haveDimensions) {
                    page = _pageController.page ?? page;
                  }
                  final delta = (page - index);
                  final distance = delta.abs().clamp(0.0, 1.0);

                  final scale = 1 - (distance * 0.22);

                  return Center(
                    child: Transform.scale(scale: scale, child: child),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: _CardFace(color: _cardColors[index]),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_cardColors.length, (index) {
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

class _CardFace extends StatelessWidget {
  final Color color;

  const _CardFace({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
