import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:grad_project/common/chat/presentation/views/chats_list_view.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/presentation/views/home_view.dart';
import 'package:grad_project/patient/features/notification/presentation/view_model/notification_number/notification_number_cubit.dart';
import 'package:grad_project/patient/features/profile/presentation/views/profile_view.dart';

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
    ChatsListView(),
    ProfileView(),
  ];

  @override
  void initState() {
     
    super.initState();

    context.read<NotificationNumberCubit>().getMyChatNotificationsNumber();
  }

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
            color: priColor
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          backgroundColor: AppTheme.background(context), //<--
          color: Colors.grey,
          activeColor: priColor,
          tabBackgroundColor: AppTheme.surfaceContainer(context),
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


            // GButton(
            //   icon: Icons.circle,
            //   leading: buildIcon(
            //     "assets/images/live_chat.png",
            //     isActive: currentIndex == 2,
            //   ),
            //   text: "المحادثة",
            // ),

GButton(
  icon: Icons.circle,
  text: "المحادثة",
  leading: BlocBuilder<NotificationNumberCubit, NotificationNumberState>(
    // بنخلي الـ Builder يشتغل بس لما الـ State تكون تخص الشات
    buildWhen: (previous, current) => current is NotificationChatNumberSuccess,
    builder: (context, state) {
      // بنجيب الرقم من المتغير اللي في الكوبيت
      int chatCount = context.read<NotificationNumberCubit>().chatNumber;
      
      return Stack(
        clipBehavior: Clip.none,
        children: [
          buildIcon(
            "assets/images/live_chat.png",
            isActive: currentIndex == 2,
          ),
          if (chatCount > 0)
            Positioned(
              left: -4, 
              top: -2,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                constraints: const BoxConstraints(
                  minWidth: 18,
                  minHeight: 18,
                ),
                child: Center(
                  child: Text(
                    chatCount > 9 ? '+9' : '$chatCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    },
  ),
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
