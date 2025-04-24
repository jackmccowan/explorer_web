// lib/components/nav_card.dart
import 'package:explorer_web/colors.dart';
import 'package:flutter/material.dart';

class NavCard extends StatelessWidget {
  final String logo;
  final String text;
  final VoidCallback onTap;
  final bool selected;

  const NavCard({
    Key? key,
    required this.logo,
    required this.text,
    required this.onTap,
    this.selected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: selected ? explorerBlue : Colors.grey.withOpacity(0.2), // Transparent background
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logo, height: 24),
            const SizedBox(height: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}