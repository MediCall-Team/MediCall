import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/chats/views/chats_view.dart';
import 'package:grad_project/patient/features/home/views/home_view.dart';


import 'package:grad_project/patient/features/profile/views/profile_view.dart';
import 'package:grad_project/patient/features/requests/presentation/views/requests_view.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int currentIndex = 0;
 final List<Widget> _widget = [
    HomeView(),
      RequestsView(),
    ChatsView(),
    ProfileView(),
    //  NotificationView(),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double iconSize = width * 0.085; // 🔹 حجم متجاوب بنسبة بسيطة جدا
    // double profileRadius = iconSize + 8;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Directionality(
        textDirection: TextDirection.ltr,
        child: SafeArea(child: _widget.elementAt(currentIndex)),
      ),
      bottomNavigationBar: Directionality(
        textDirection: TextDirection.ltr,
        child: BottomNavigationBar(
         type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/home.svg",
                width: iconSize,
                color: currentIndex == 0 ? kPrimaryColorB : Colors.grey,
              ),
              label: "الرئيسية",
            ),

            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/interview.png",
                width: iconSize,
                color: currentIndex == 1 ? kPrimaryColorB : Colors.grey,
              ),
              label: "الطلبات",
            ),

            // BottomNavigationBarItem(
            //   icon: Transform.translate(
            //     offset: const Offset(0, -14), // 🔹 ارفعي النص والأيقونة سوا
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: [
            //         CircleAvatar(
            //           backgroundColor: kPrimaryColorB,
            //           radius: 25 + width * 0.015,
            //           child: SvgPicture.asset(
            //             "assets/images/profile.svg",
            //             width: iconSize,
            //           ),
            //         ),
            //         const SizedBox(height: 2),
            //         Text(
            //           "الملف الشخصي",
            //           style: TextStyle(
            //             fontSize: width * 0.035,
            //             color: currentIndex == 2 ? kPrimaryColorB : Colors.grey,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   label: "", // ❌ لازم نخليه فاضي علشان ميتكررش لتحت
            // ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/live_chat.png",
                width: iconSize + 5,
                color: currentIndex == 2 ? kPrimaryColorB : Colors.grey,
              ),

              label: "المحادثة",
            ),

            // BottomNavigationBarItem(
            //   icon: SvgPicture.asset(
            //     "assets/images/notification.svg",
            //     width: iconSize - 10,
            //     color: currentIndex == 4 ? kPrimaryColorB : Colors.grey,
            //   ),
            //   label: "الإشعارات",
            // ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                "assets/images/profile.svg",
                width: iconSize,
                color: currentIndex == 3 ? kPrimaryColorB : Colors.grey,
              ),

              label: "الملف الشخصي",
            ),
          ],
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          selectedItemColor: kPrimaryColorB,
          showSelectedLabels: true,
          unselectedItemColor: Colors.grey,
          selectedFontSize: (width * 0.035) + 1,
          unselectedFontSize: width * 0.035,
        ),
      ),
    );
  }
}
