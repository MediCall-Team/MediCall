
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/authentication/presentation/widgets/custom_botton.dart';
import 'package:grad_project/features/onboarding/presentation/views/first_page_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/five_pgae_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/four_page_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/second_page_view.dart';
import 'package:grad_project/features/onboarding/presentation/views/third_page_view.dart';
import 'package:grad_project/core/utils/app_router.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _PageViewState();
}

class _PageViewState extends State<OnboardingPageView> {
 late PageController _controller;
  int index=0;

  @override
  void initState() {
    _controller=PageController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: 
      Column(
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: PageView(
               
                onPageChanged: (value){
                  setState(() {
                     index=value;
                     print(index);
                  });
                 
                },
                controller: _controller,
                children: [
                  FirstPageView(),
                  SecondPageView(),
                  ThirdPageView(),
                  FourPageView(),
                  FivePgaeView()
                ],
              ),
            ),
          ),
          SizedBox(height: 40,),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIndecator(isActive: index==0),
                CustomIndecator(isActive: index==1),
                CustomIndecator(isActive: index==2),
                CustomIndecator(isActive: index==3),
                CustomIndecator(isActive: index==4),
              ],
            ),
          ),
          SizedBox(height: 30,),
          CustomButton(onPressed: (){
            if(index<4){
              _controller.animateToPage(index+1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            }else if(index==4){
          
          GoRouter.of(context).go(AppRouter.kLoginPage);
            }
          }, text: "التالي"),
          SizedBox(height: 30,)
        ],

      )
      ),
    );
  }
}

class CustomIndecator extends StatelessWidget {
  const CustomIndecator({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: AnimatedContainer(duration: Duration(milliseconds: 300),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isActive?kPrimaryColorB:Color(0xffd9d9d9)
      ),
      ),
    );
  }
}