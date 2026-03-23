import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/constants.dart';

class CostumSearchBottom extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CostumSearchBottom({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return TextField(
      onChanged: onChanged, // 👈 هنا المهم
      decoration: InputDecoration(
        hintText: "ابحث عن تخصص",
        hintStyle: TextStyle(
          fontFamily: "Tajawal",
          fontSize: (screenWidth * 0.03).clamp(16, 22),
        ),
        prefixIcon: const Icon(Icons.search),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: kPrimaryColorC, width: 1.5),
    );
  }
}
