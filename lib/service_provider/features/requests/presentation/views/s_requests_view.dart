import 'package:flutter/material.dart';
import 'package:grad_project/core/utils/styles.dart';
import 'package:grad_project/service_provider/features/requests/presentation/widgets/s_requests_view_body.dart';


class SRequestsView extends StatelessWidget {
  const SRequestsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
      
        appBar: AppBar(
          title: Text("الطلبات",style: Styles.textStyle25),
        ),
        body: SafeArea(child: SRequestsViewBody())),
    );
  }
}