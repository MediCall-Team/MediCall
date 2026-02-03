
import 'package:flutter/material.dart';

class RateBar extends StatelessWidget {
  final String label;
  final double count;
  final double total;
  final double screenWidth;

  const RateBar({
    super.key,
    required this.label,
    required this.count,
    required this.total, required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    double percent = total == 0 ? 0 : count / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: Colors.grey.shade300,
                color: const Color(0xff40B1D8),
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 8),

          Text(label, style:  TextStyle(
            fontSize: screenWidth*0.034//12
          
          , color: Colors.grey)),
        ],
      ),
    );
  }
}
