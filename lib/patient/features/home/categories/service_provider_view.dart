import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/home/categories/widgets/service_provider_view_body.dart';

class ServiceProviderView extends StatelessWidget {
  const ServiceProviderView({required this.cName});
  final String cName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cName,style: Styles.textStyle25,),),
      body: SafeArea(child: ServiceProviderViewBody()
      ),
    );
  }
}