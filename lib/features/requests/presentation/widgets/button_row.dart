
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/requests/presentation/widgets/custom_request_button.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: SizedBox()),

        CustomRequestButton(
          text: "الغاء الطلب",
          icon: "assets/images/trash.svg",
          color: Colors.white,
          textColor: kPrimaryColorC,
        ),

        Expanded(flex: 2, child: SizedBox()),
        CustomRequestButton(
          text: "تعديل الطلب",
          icon: "assets/images/pin.svg",
          color: kPrimaryColorB,
          textColor: Colors.white,
        ),
        Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
