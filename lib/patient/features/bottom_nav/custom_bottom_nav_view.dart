import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/chats/views/chats_view.dart';
import 'package:grad_project/patient/features/home/views/home_view.dart';

import 'package:grad_project/patient/features/profile/views/profile_view.dart';
import 'package:grad_project/patient/features/requests/presentation/views/requests_view.dart';

class CustomBottomNavView extends StatefulWidget {
  const CustomBottomNavView({super.key});

  @override
  State<CustomBottomNavView> createState() => _CustomBottomNavViewState();
}

class _CustomBottomNavViewState extends State<CustomBottomNavView> {
  int currentIndex = 0;

  final List<Widget> _widget = [
    HomeView(),
    RequestsView(),
    ChatsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.079; 

    Widget buildIcon(String path, {bool isSvg = false, bool isActive = false}) {
      return SizedBox(
        width: iconSize,
        height: iconSize,
        child: isSvg
            ? SvgPicture.asset(
                path,
                width: iconSize,
              //  height: iconSize,
                color: isActive ? kPrimaryColorB : Colors.grey,
                fit: BoxFit.contain,
              )
            : Image.asset(
                path,
                width: iconSize,
              //  height: iconSize,
                color: isActive ? kPrimaryColorB : Colors.grey,
                fit: BoxFit.contain,
              ),
      );
    }

//     Widget buildIcon(String path,
//     {bool isSvg = false, bool isActive = false}) {
//   return Center(
//     child: isSvg
//         ? SvgPicture.asset(
//             path,
//             width: iconSize,
//             color: isActive ? kPrimaryColorB : Colors.grey,
//           )
//         : Image.asset(
//             path,
//             width: iconSize,
//             color: isActive ? kPrimaryColorB : Colors.grey,
//           ),
//   );
// }


    return Scaffold(
  extendBody: true,
  body: Directionality(
    textDirection: TextDirection.ltr,
    child: SafeArea(
      bottom: true, // مهم
      child: _widget[currentIndex],
    ),
  ),

  bottomNavigationBar: Directionality(
    textDirection: TextDirection.ltr,
    child: SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
        child: GNav(
          gap: 8,
          
          textStyle: TextStyle(
            fontSize: width * 0.033,
            fontWeight: FontWeight.w500,
            fontFamily: "Tajawal",
            color: kPrimaryColorB
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          backgroundColor: Colors.white, //<--
          color: Colors.grey,
          activeColor: kPrimaryColorB,
          tabBackgroundColor: kPrimaryColorB.withOpacity(0.1),
          onTabChange: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          tabs: [
            GButton(
              icon: Icons.circle,
              leading: buildIcon(
                "assets/images/home.svg",
                isSvg: true,
                isActive: currentIndex == 0,
              ),
              text: "الرئيسية",
            ),
            GButton(
              icon: Icons.circle,
              leading: buildIcon(
                "assets/images/interview.png",
                isActive: currentIndex == 1,
              ),
              text: "الطلبات",
            ),
            GButton(
              icon: Icons.circle,
              leading: buildIcon(
                "assets/images/live_chat.png",
                isActive: currentIndex == 2,
              ),
              text: "المحادثة",
            ),
            GButton(
              icon: Icons.circle,
              leading: buildIcon(
                "assets/images/profile.svg",
                isSvg: true,
                isActive: currentIndex == 3,
              ),
              text: "الملف الشخصي",
            ),
          ],
        ),
      ),
    ),
  ),
);

  }
}
