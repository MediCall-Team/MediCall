import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/authentication/data/patient_user_model.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/theme_toggle.dart';
import 'package:grad_project/patient/features/notification/views/notification_view.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class Header extends StatefulWidget {
  const Header({
    super.key,
    required this.fontSize,
    required this.iconSize,
    required this.screenWidth,
  });

  final double fontSize;
  final double iconSize;
  final double screenWidth;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late PatientUserModel userModel;
  @override
  void initState() {
    userModel = CacheHelper.getUser()!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        children: [
          ThemeToggleApp(),
          //const SizedBox(width: 5),
          // الحل: استخدام Icon بدل SVG
          widget.screenWidth < 550
              ? IconButton(
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
                    size: widget.iconSize,
                    color: Colors.grey,
                  ),
                )
              : SizedBox(),

          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "مرحبا",
                style: TextStyle(
                  color: Color(0xFFCAC7C7), //AppTheme.textSecondary(context),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w500,
                  fontSize: widget.fontSize.clamp(12, 25),
                ),
              ),
              Text(
                userModel.fullName,
                style: TextStyle(
                  color: AppTheme.brandColor(
                    context,
                  ), //AppTheme.secondary(context),
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.w700,
                  fontSize: widget.fontSize.clamp(10, 18),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),

        ClipOval(
  child: CachedNetworkImage(
    imageUrl: userModel.imageUrl,
    width: widget.iconSize.clamp(35, 80),
    height: widget.iconSize.clamp(35, 80),
    fit: BoxFit.cover,
    errorWidget: (context, url, error) => Icon(Icons.error),
    placeholder: (context, url) => Shimmer(
     // baseColor: Colors.grey.shade300,
     // highlightColor: Colors.grey.shade100,
      child: Container(
        width: widget.iconSize.clamp(35, 80),
        height: widget.iconSize.clamp(35, 80),
        decoration: BoxDecoration(
          color: Colors.grey,
          shape: BoxShape.circle,
        ),
      ),
    ),
  ),
)
          // CircleAvatar(
          //   radius: widget.iconSize.clamp(10, 40),
          //   backgroundImage:CachedNetworkImageProvider(userModel.imageUrl)

          //   //const AssetImage("assets/images/sera.png"),
          // ),
        ],
      ),
    );
  }
}
