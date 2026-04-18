import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/data/chats_list_model.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/common/chat/presentation/view_model/messages_list/messages_list_cubit.dart';
import 'package:grad_project/common/chat/presentation/widgets/chat_room_view_body.dart';
import 'package:grad_project/common/chat/presentation/widgets/medical_queck_actions.dart';
import 'package:grad_project/common/chat/repo/chat_repo.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/core/utils/styles.dart';

class ChatRoomView extends StatelessWidget {
  const ChatRoomView({super.key, required this.chatData});

  final ChatData chatData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 40,
        titleSpacing: 5,
        title: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(chatData.otherPersonImage),
            ),
            const SizedBox(width: 10),
            Text(
              chatData.otherPersonName,
              style: Styles.textStyle20.copyWith(
                color: AppTheme.mainContrast(context),
              ),
            ),
            const Spacer(),

            /// 🔥 ده المهم
            BlocBuilder<ChatsLitsCubit, ChatsLitsState>(
              builder: (context, state) {
                late bool isClosed;

                if (state is ChatsLitsSuccess) {
                  log("change chat state success");
                  final chat = state.chatsList.firstWhere(
                    (c) => c.chatId == chatData.chatId,
                    orElse: () => chatData,
                  );

                  isClosed = chat.isClosed;
                }

                return CacheHelper.getUser()!.role != "Patient"?  IconButton(
                  onPressed: () {
                    //final chatsCubit = context.read<ChatsLitsCubit>();

                    showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return MedicalQuickActions(
                          chatId: chatData.chatId,
                          isClosed: isClosed, // ✅ الصح
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.more_vert),
                ):SizedBox() ;
              },
            ),
          ],
        ),
      ),
      body: SafeArea(child: ChatRoomViewBody(chatData: chatData)),
    );
  }
}
