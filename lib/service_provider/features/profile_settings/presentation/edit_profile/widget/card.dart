import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MyCard({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF35AAD5)
                  : Colors.grey.shade100,
              width: 2,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 6,
                height: 25,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF35AAD5)
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    color: const Color(0xFF1F3E6C),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle : Icons.add_circle_outline,
                color: isSelected
                    ? const Color(0xFF35AAD5)
                    : Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
