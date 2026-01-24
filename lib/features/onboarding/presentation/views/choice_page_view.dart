
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/authentication/presentation/widgets/custom_botton.dart';
import 'package:grad_project/features/onboarding/presentation/widgets/custom_button_choice.dart';
import 'package:grad_project/core/utils/app_router.dart';

class ChoicePageView extends StatefulWidget {
  const ChoicePageView({super.key});

  @override
  State<ChoicePageView> createState() => _ChoicePageViewState();
}

class _ChoicePageViewState extends State<ChoicePageView> {
  bool isActive1 = false;
  bool isActive2 = false;
  String type = "";
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            children: [
              SizedBox(height: 30),
              Container(
                height: 40, // ارتفاع أقل للحاوية حول اللوجو
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/medicall2(1)(1).png",
                  //  width: 250,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "من أنت؟",
                style: TextStyle(
                  color: kPrimaryColorC,
                  fontFamily: "Tajawal",
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                ".حدد دورك للمتابعة",
                style: TextStyle(
                  color: kPrimaryColorB,
                  fontFamily: "Tajawal",
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isActive2 = false;
                      isActive1 = true;
                      type = "DN";
                    });
                  },
                  child: CustomChoiceButton(
                    isActive: isActive1,
                    text: "دكتور/ممرض",
                    image: "assets/images/image 3 (1).png",
                  ),
                ),
              ),
              SizedBox(height: 15),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isActive1 = false;
                      isActive2 = true;
                      type = "P";
                    });
                  },
                  child: CustomChoiceButton(
                    isActive: isActive2,
                    text: "مريض",
                    image: "assets/images/image 4 (1).png",
                  ),
                ),
              ),
          
              Spacer(),
              CustomButton(onPressed: () {
                if(type.isNotEmpty){
               if(type=="DN"){
                GoRouter.of(context).push(AppRouter.kSignUp);
               }
                }else{
                snackBarMethod(context, "you must choice one");
                }
              }, text: "استمر"),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
    void snackBarMethod(BuildContext context,String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
