import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/common/chat/presentation/widgets/chats_list_view_body.dart';
import 'package:grad_project/common/chat/repo/chat_repo.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';

class ChatsListView extends StatelessWidget {
  const ChatsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          //surfaceTintColor: Colors.transparent,
          title: Text(
            "المحادثات",
            style: Styles.textStyle25.copyWith(
              color: AppTheme.mainContrast(context),
            ),
          ),
        ),
      body: SafeArea(child: ChatsListViewBody()));
  }
}