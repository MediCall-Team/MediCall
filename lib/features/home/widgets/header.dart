import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/home/widgets/theme_toggle.dart';
import 'package:grad_project/features/notification/views/notification_view.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.fontSize, required this.iconSize});

  final double fontSize;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          ThemeToggleApp(),
          //const SizedBox(width: 5),
          // الحل: استخدام Icon بدل SVG
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationView(),
                ),
              );
            },
            icon: Icon(
              Icons.notifications_outlined,
              size: iconSize,
              color: Colors.grey,
            ),
          ),

          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "مرحبا",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: fontSize,
                ),
              ),
              Text(
                "ندي الشيمي",
                style: TextStyle(
                  color: kPrimaryColorC,
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            radius: iconSize,
            backgroundImage: const AssetImage("assets/images/sera.png"),
          ),
        ],
      ),
    );
  }
}
