import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/widgets/more_categories_body.dart';

class MoreCategoriesView extends StatelessWidget {
  const MoreCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(title: Text('اختر التخصص',style: 
         Styles.textStyle25.copyWith(
          color: AppTheme.mainContrast(context)
         )
         ,),),
         body: SafeArea(child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 12),
           child: MoreCategoriesBody(),
         )),
    );
  }
}