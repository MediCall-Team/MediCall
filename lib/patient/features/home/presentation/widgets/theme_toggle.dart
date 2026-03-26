import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/patient/features/home/presentation/view_models/cubit/app_theme_cubit.dart';


class ThemeToggleApp extends StatelessWidget {
  const ThemeToggleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AppThemeCubit>();
    final isDark = cubit.isDark;

    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: GestureDetector(
        onTap: () {
          context.read<AppThemeCubit>().toggleTheme();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 42,
          height: 18,
          decoration: BoxDecoration(
            color: isDark
                ? Theme.of(context).colorScheme.secondary
                : Theme.of(context).colorScheme.primary,
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
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDark ? Icons.dark_mode : Icons.wb_sunny,
                    size: 12,
                    color: Theme.of(context).colorScheme.primary,
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