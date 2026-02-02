import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/features/home/categories/widgets/more_categories_body.dart';

class MoreCategoriesView extends StatelessWidget {
  const MoreCategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(title: Text('اختر التخصص',style: Styles.textStyle25,),),
         body: SafeArea(child: MoreCategoriesBody()),
    );
  }
}