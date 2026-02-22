import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class WriteMessage extends StatelessWidget {
  const WriteMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: priColor,
            child: IconButton(
              icon: Transform.rotate(
                angle: 3*math.pi / 4, // -45° ↗
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              onPressed: () {
                // send message
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...',
                hintStyle: TextStyle(color:  Color(0xff9C9C9C),),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xff9C9C9C)),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:Color(0xff9C9C9C), width: 1.5),
                  borderRadius: BorderRadius.circular(30),
                ),
                filled: true,
                fillColor: Color(0xffF5F7F7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}