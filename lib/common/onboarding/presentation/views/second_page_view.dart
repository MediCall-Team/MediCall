
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class SecondPageView extends StatelessWidget {
  const SecondPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return  
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
              Expanded(child: 
              Image.asset("assets/images/Online Doctor-amico 1 (1).png")
              ),

              Align(
               // alignment: Alignment.centerRight,
               alignment: AlignmentGeometry.directional(0.5, 0),
                child: _buildText( "اختر المتخصص \nالمناسب لك")),

                 Align(
                alignment: Alignment.center,
                child: Text(
                  "تعرّف على المتخصصين المتاحين من أطباء\n وتمريض ومعالجين. اطّلع على الخبرة والمراجعات\n، واختر الأفضل لك.",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: kPrimaryColorB,
                    fontSize: 14,
                    fontFamily: "Tajawal",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        ],
      )
    ;
  }

  
  Widget _buildText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        text,
        textAlign: TextAlign.right,
        style: TextStyle(
          color: kPrimaryColorB,
          fontSize: 30,
          fontFamily: "Tajawal",
          fontWeight: FontWeight.w700,
         // height: 1.4,
        ),
      ),
    );
  }
}