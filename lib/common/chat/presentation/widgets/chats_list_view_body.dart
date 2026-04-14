import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/common/chat/presentation/widgets/ChatItem.dart';
import 'package:grad_project/core/helper/reusable_shimmer.dart';

class ChatsListViewBody extends StatefulWidget {
  const ChatsListViewBody({super.key});

  @override
  State<ChatsListViewBody> createState() => _ChatsListViewBodyState();
}

class _ChatsListViewBodyState extends State<ChatsListViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChatsLitsCubit>().loadFirstPage();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<ChatsLitsCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          // --- حقل البحث ---
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 45,
              child: TextFormField(
                textAlign: TextAlign.right,
                onChanged: (value) {
                  context.read<ChatsLitsCubit>().searchChats(value.isEmpty ? null : value);
                },
                decoration: InputDecoration(
                  hintText: 'بحث',
                  hintStyle: const TextStyle(color: Color(0xFFD9D9D9), fontSize: 16),
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFD9D9D9), size: 22),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: kPrimaryColorB, width: 1.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ),

          // --- عداد الرسائل غير المقروءة (التعديل الجديد) ---
          BlocBuilder<ChatsLitsCubit, ChatsLitsState>(
            builder: (context, state) {
              final cubit = context.read<ChatsLitsCubit>();
              if (state is ChatsLitsSuccess && cubit.unReadChats > 0) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: kPrimaryColorB.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                         
                          children: [
                            Icon(Icons.mark_chat_unread_rounded, size: 18, color: kPrimaryColorB),
                            const SizedBox(width: 8),
                            Text(
                              "لديك ",
                              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                            ),
                            Text(
                              "${cubit.unReadChats}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColorB,
                              ),
                            ),
                            Text(
                              " محادثات غير مقروءة",
                              style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),

          const SizedBox(height: 12),

          // --- قائمة المحادثات ---
          Expanded(
            child: BlocBuilder<ChatsLitsCubit, ChatsLitsState>(
              builder: (context, state) {
                if (state is ChatsLitsLoading) {
                  return ListView.builder(
                    itemCount: 8,
                    itemBuilder: (context, index) => const ReusableShimmer(),
                  );
                } else if (state is ChatsLitsSuccess) {
                  final chats = state.chatsList;

                  if (chats.isEmpty) {
                    return const Center(child: Text("لا توجد محادثات"));
                  }

                  return ListView.separated(
                    controller: _scrollController,
                    itemCount: chats.length + (state.isLoadingMore ? 1 : 0),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade300,
                      thickness: 0.5,
                      indent: 70,
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      if (index < chats.length) {
                        return ChatItem(chatData: chats[index]);
                      } else {
                        return const ReusableShimmer();
                      }
                    },
                  );
                } else if (state is ChatsLitsFailure) {
                  return Center(child: Text(state.errorMsg));
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}