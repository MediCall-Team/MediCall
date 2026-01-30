import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.flibx = false,
  });

  final IconData icon;
  final String title;
  final IconData? trailing;
  final VoidCallback? onTap;
  final bool flibx;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap:onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                // Leading icon
                Transform.flip(
                  flipX: flibx,
                  child: Icon(
                    icon,
                    color: secColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                ),
                
                // Trailing icon
                if (trailing != null)
                  Icon(
                    trailing,
                    color: secColor,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}