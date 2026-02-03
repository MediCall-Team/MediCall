import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/patient/features/requests/presentation/widgets/requests_view_body.dart';

class RequestsView extends StatelessWidget {
  const RequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      
        appBar: AppBar(
          title: Text("الطلبات",style: Styles.textStyle25),
        ),
        body: SafeArea(child: RequestsViewBody())),
    );
  }
}