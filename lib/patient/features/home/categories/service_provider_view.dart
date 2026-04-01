import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/app_theme.dart';

import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/widgets/service_provider_view_body.dart';

// تقريبا الصفحه دي متكرره محدش يشتغل فيها لحد ما نتأكد
//*حاضر

class ServiceProviderView extends StatelessWidget {
  const ServiceProviderView({required this.cName});
  final String cName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cName,
          style: Styles.textStyle25.copyWith(
            color: AppTheme.mainContrast(context),
          ),
        ),
      ),
      // body: SafeArea(child: ServiceProviderViewBody()),
    );
  }
}

 // تقريبا الصفحه دي متكرره محدش يشتغل فيها لحد ما نتأكد