import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';

class TimeRequestSection extends StatelessWidget {
  const TimeRequestSection({
    super.key,
    required this.time,
    required this.date,
    required this.screenWidth,
  });

  final String time;
  final String date;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox()),

        SvgPicture.asset(
          "assets/images/clock.svg",
          width: (screenWidth * 0.045),
        ),

        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceToGrey(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              time,
              style: TextStyle(
                color: kPrimaryColorC,
                fontWeight: FontWeight.w600,
              ).copyWith(
                fontSize: (screenWidth * 0.03).clamp(12, 24),
              ),
            ),
          ),
        ),

        Expanded(child: SizedBox()),

        SvgPicture.asset(
          "assets/images/calendar.svg",
          width: (screenWidth * 0.045),
        ),
        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceToGrey(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              date,
              style: TextStyle(
                color: kPrimaryColorC,
                fontWeight: FontWeight.w600,
              ).copyWith(fontSize: (screenWidth * 0.03).clamp(12, 24)),
            ),
          ),
        ),

        Expanded(child: SizedBox()),
      ],
    );
  }
}