import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/patient/features/home/presentation/cubit/ai_cubit.dart';
import 'package:grad_project/patient/features/home/presentation/cubit/ai_state.dart';
import 'package:lottie/lottie.dart';

class AiViewBody extends StatefulWidget {
  const AiViewBody({super.key});

  @override
  State<AiViewBody> createState() => _AiViewBodyState();
}

class _AiViewBodyState extends State<AiViewBody> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(2),
                child: LottieBuilder.asset(
                  "assets/animation/eve.json",
                  width: screenWidth * 0.4,
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // العنوان الرئيسي
            Text(
              textAlign: TextAlign.end,
              "ادخل الاعراض لتحديد التخصص الطبي",
              style: TextStyle(
                fontSize: (screenWidth * 0.05).clamp(16, 24),
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1A237E),
              ),
            ),

            const SizedBox(height: 20),

            // ملصق وصف الحالة
            const Text(
              textAlign: TextAlign.end,
              "وصف الحالة",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: "Poppins",
              ),
            ),

            const SizedBox(height: 10),

            // حقل إدخال الأعراض
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F2),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _controller,
                minLines: 4,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: "اكتب الأعراض التي تشعر بها...",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(screenWidth * 0.04),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // زر "توقع التخصص"
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      context.read<AiCubit>().consult(text);
                      _controller.clear();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "توقع التخصص",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: (screenWidth * 0.045).clamp(14, 18),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: screenHeight * 0.04),

            // صندوق رد الـ AI
            BlocBuilder<AiCubit, AiState>(
              builder: (context, state) {
                if (state is AiLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF1565C0)),
                  );
                }

                if (state is AiFailure) {
                  return _BotMessageBox(
                    message: state.errorMsg,
                    screenWidth: screenWidth,
                    isError: true,
                  );
                }

                if (state is AiSuccess) {
                  return _BotMessageBox(
                    message: state.botReply,
                    screenWidth: screenWidth,
                  );
                }

                // AiInitial - رسالة ترحيبية
                return _BotMessageBox(
                  message:
                      "مرحباً! أنا هنا لمساعدتك في تحديد التخصص الطبي المناسب. اكتب الأعراض التي تشعر بها وسأحاول مساعدتك.",
                  screenWidth: screenWidth,
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class _BotMessageBox extends StatelessWidget {
  final String message;
  final double screenWidth;
  final bool isError;

  const _BotMessageBox({
    required this.message,
    required this.screenWidth,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();
    final hour = now.hourOfPeriod == 0 ? 12 : now.hourOfPeriod;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.period == DayPeriod.am ? 'ص' : 'م';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: isError ? const Color(0xFFFFEBEE) : const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  message,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: (screenWidth * 0.035).clamp(12, 15),
                    color: isError
                        ? Colors.red.shade700
                        : const Color(0xFF455A64),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "$hour:$minute $period",
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
