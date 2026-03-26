import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
class UserInfo extends StatelessWidget {
  const UserInfo({
    super.key,
    required this.icon,
    required this.title,
    this.trailing,
    this.onTap,
    this.onEditTap, // 🆕
    this.flibx = false,
  });

  final IconData icon;
  final String title;
  final IconData? trailing;
  final VoidCallback? onTap;
  final VoidCallback? onEditTap; // 🆕
  final bool flibx;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Transform.flip(
                  flipX: flibx,
                  child: Icon(
                    icon,
                    color: secColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (trailing != null)
                  GestureDetector(
                    onTap: onEditTap, // هنا نستخدم onEditTap
                    child: Icon(
                      trailing,
                      color: secColor,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}