
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.text, required this.onRemove});
  final String text;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xffE1F2F8),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: onRemove,
              child: const Icon(Icons.close, size: 18),
            ),
            const SizedBox(width: 10),
            Text(text, style: const TextStyle(fontFamily: "Tajawal")),
          ],
        ),
      ),
    );
  }
}