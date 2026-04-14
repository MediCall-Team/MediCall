import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/common/chat/presentation/view_model/chats_list/chats_lits_cubit.dart';
import 'package:grad_project/constants.dart';

import 'package:grad_project/common/chat/presentation/widgets/ChatItem.dart';
import 'package:grad_project/core/helper/reusable_shimmer.dart';
// تأكدي من المسار

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
    // جلب أول صفحة عند فتح الشاشة
    context.read<ChatsLitsCubit>().loadFirstPage();
    
    // إضافة مستمع للـ scroll لتفعيل الـ Pagination
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
          // حقل البحث
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 45,
              child: TextFormField(
                textAlign: TextAlign.right,
                onChanged: (value) {
                  // نداء ميثود البحث (يفضل إضافة Debounce لاحقاً)
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
          const SizedBox(height: 12),
          
          Expanded(
            child: BlocBuilder<ChatsLitsCubit, ChatsLitsState>(
              builder: (context, state) {
                if (state is ChatsLitsLoading) {
                  // شيمر في حالة التحميل لأول مرة
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
                    controller: _scrollController, // الربط مع الكنترولر
                    itemCount: chats.length + (state.isLoadingMore ? 1 : 0),
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.grey.shade300,
                      thickness: 0.5,
                      indent: 70, // المسافة من جهة الصورة
                      endIndent: 16,
                    ),
                    itemBuilder: (context, index) {
                      if (index < chats.length) {
                        return ChatItem(chatData: chats[index]);
                      } else {
                        // الشيمر يظهر تحت الليست في حالة تحميل المزيد
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