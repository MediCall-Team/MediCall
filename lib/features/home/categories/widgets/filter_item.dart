
import 'package:flutter/material.dart';

class FilterItem extends StatelessWidget {
  const FilterItem({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {

    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 14),
        decoration: BoxDecoration(
          color: const Color.fromARGB(143, 115, 123, 128),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Icon(Icons.close),SizedBox(width: 10,), Text(text)]),
      ),
    );
  }
}