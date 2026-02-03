import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class ThemeToggleApp extends StatelessWidget {
  const ThemeToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = false; 

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          //context.read<ThemeCubit>().toggleTheme(); 
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 42, 
          height: 18, 
          decoration: BoxDecoration(
            color: isDark ? Colors.black : priColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                left: isDark ? 25 : 2, 
                top: 1.5,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode : Icons.wb_sunny,
                    size: 12,
                    color: isDark ? Colors.black :priColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
