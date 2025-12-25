import 'package:ewallet/features/shared/source/domain/entities/source.dart';
import 'package:flutter/material.dart';

class SourceWidget extends StatelessWidget {
  final List<Source> sources;
  final String currency;

  const SourceWidget({Key? key, required this.sources, this.currency = "₹"})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.8;

    const List<Color> sourceColorPalette = [
      Color(0xFF6A5AE0),
      Color(0xFF00B4D8),
      Color(0xFF2EC4B6),
      Color(0xFFFF9F1C),
      Color(0xFFEF476F),
    ];
    Color getSourceColor(int index) {
      return sourceColorPalette[index % sourceColorPalette.length];
    }

    return SizedBox(
      height: 200,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.85),
        itemCount: sources.length,
        itemBuilder: (context, index) {
          final source = sources[index];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              width: cardWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: getSourceColor(index),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withAlpha(40),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(51),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: _CardContent(
                sourceName: source.name,
                balance: source.money.inRupees,
                currency: currency,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  final String sourceName;
  final double balance;
  final String currency;

  const _CardContent({
    required this.sourceName,
    required this.balance,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sourceName,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Current Balance",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Text(
          "$currency ${balance.toStringAsFixed(2)}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.account_balance, color: Colors.white70),
            Icon(Icons.credit_card, color: Colors.white70),
          ],
        ),
      ],
    );
  }
}
