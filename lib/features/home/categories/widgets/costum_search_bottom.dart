import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:grad_project/constants.dart';

class CostumSearchBottom extends StatelessWidget {
  const CostumSearchBottom({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Expanded(
      child: TextField(
        decoration: InputDecoration(
          hintText: "ابحث عن تخصص",
          hintStyle: TextStyle(
            fontFamily: "Tajawal",
            fontSize: (screenWidth * 0.03).clamp(16, 22),
          ),
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(Icons.search),
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder()
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(40),
      borderSide: BorderSide(color: kPrimaryColorC, width: 1.5),
    );
  }
}
