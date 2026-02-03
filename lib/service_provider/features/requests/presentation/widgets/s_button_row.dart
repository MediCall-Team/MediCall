
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_custom_request_button.dart';

class SButtonRow extends StatelessWidget {
  const SButtonRow({super.key, required this.screenWidth});
  final double screenWidth;
  
  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        Expanded(flex: 1, child: SizedBox()),

        SCustomRequestButton(
          onTap: (){

          },
          screenWidth: screenWidth,
          text: "الغاء الطلب",
          icon: Icons.cancel_outlined,
          color: Colors.white,
          textColor: kPrimaryColorC,
        ),

        Expanded(flex: 3, child: SizedBox()),
        
        SCustomRequestButton(
          onTap: (){
            
          },
          screenWidth: screenWidth,
          text: "تأكيد الطلب",
          icon: Icons.done,
          color: kPrimaryColorB,
          textColor: Colors.white,
        ),
        Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
