import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class Steps extends StatelessWidget {
  const Steps({super.key, required this.num});
  final int num;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        ...List.generate(3, (i) {
          int index = i + 1;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Circle(colored: num == index),
          );
        }),
        Text('  الخطوة$num',style: TextStyle(color: secColor,fontSize: 15,fontWeight: FontWeight.w700),)
      ],
    );
  }
}

class Circle extends StatelessWidget {
  const Circle({super.key, required this.colored});
  final bool colored;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 4, // خلتها أكبر شوية شكلاً أفضل
      backgroundColor: colored ? secColor : Colors.grey,
    );
  }
}
