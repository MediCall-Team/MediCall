
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/requests/data/model/request_model.dart';
import 'package:intl/intl.dart';

class TimeRequestSection extends StatelessWidget {
  const TimeRequestSection({
    super.key,
    required this.timeFormat,
    required this.requestmodel,
    required this.dateFormat,
  });

  final DateFormat timeFormat;
  final RequestModel requestmodel;
  final DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        SvgPicture.asset("assets/images/clock.svg"),
        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColorD,
            borderRadius: BorderRadius.circular(16),
          ),

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              timeFormat.format(requestmodel.date),
              style: TextStyle(
                color: kPrimaryColorC,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        Expanded(child: SizedBox()),

        SvgPicture.asset("assets/images/calendar.svg"),
        SizedBox(width: 5),
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColorD,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dateFormat.format(requestmodel.date),
              style: TextStyle(
                color: kPrimaryColorC,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        Expanded(child: SizedBox()),
      ],
    );
  }
}
