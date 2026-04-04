
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/requests/data/model/request_model.dart';
import 'package:grad_project/service_provider/features/requests/data/model/requests_model.dart';
import 'package:intl/intl.dart';

class TimeRequestSection extends StatelessWidget {
  const TimeRequestSection({
    super.key,
    required this.timeFormat,
    required this.requestmodel,
    required this.dateFormat, required this.screenWidth,
  });

  final DateFormat timeFormat;
  final RequestData requestmodel;
  final DateFormat dateFormat;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox()),

        SvgPicture.asset("assets/images/clock.svg",
        width: (screenWidth*0.045),
        ),

        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color:AppTheme.surfaceToGrey(context) ,//kPrimaryColorD,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              timeFormat.format(requestmodel.appointmentDate),
              style: TextStyle(
                color: kPrimaryColorC,
                fontWeight: FontWeight.w600,
              ).copyWith(
                fontSize: (screenWidth*0.03).clamp(12, 24)
              ),
            ),
          ),
        ),

        Expanded(child: SizedBox()),

        SvgPicture.asset("assets/images/calendar.svg",
        width: (screenWidth*0.045),
        ),
        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color:AppTheme.surfaceToGrey(context) ,//kPrimaryColorD,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dateFormat.format(requestmodel.appointmentDate),
              style: TextStyle(
                color: kPrimaryColorC,
                fontWeight: FontWeight.w600,
              ).copyWith(fontSize: (screenWidth*0.03).clamp(12, 24)),
            ),
          ),
        ),

        Expanded(child: SizedBox()),
      ],
    );
  }
}
