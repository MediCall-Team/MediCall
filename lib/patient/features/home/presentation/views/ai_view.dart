import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/api/dio_consumer.dart';
import 'package:grad_project/patient/features/home/presentation/cubit/ai_cubit.dart';
import 'package:grad_project/patient/features/home/presentation/repo/AiRepositoryImpl.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/ai_view_body.dart';
import 'package:dio/dio.dart';

class AiView extends StatelessWidget {
  const AiView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AiCubit(
        aiRepository: AiRepositoryImpl(apiConsumer: DioConsumer(dio: Dio())),
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF0D47A1)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const SafeArea(child: AiViewBody()),
      ),
    );
  }
}
