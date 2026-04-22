import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';

class AboutAppView extends StatefulWidget {
  const AboutAppView({super.key});

  @override
  State<AboutAppView> createState() => _AboutAppViewState();
}

class _AboutAppViewState extends State<AboutAppView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("عن التطبيق"), centerTitle: true),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                /// 🔥 Logo
                Image.asset("assets/images/medicall2(1)(1).png", height: 120),

                const SizedBox(height: 30),

                /// 🔥 Card
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 194, 226, 237),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    "تطبيق Medicall هو منصة ذكية لربط المرضى بمقدمي الخدمة الطبية بسهولة وسرعة.\n\n"
                    "يهدف التطبيق إلى تسهيل الوصول للخدمات الصحية مثل الحجز، الزيارات المنزلية، "
                    "والتواصل مع الأطباء بطريقة آمنة وسهلة.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: kPrimaryColorC,
                    ),
                  ),
                ),

                const Spacer(),

                /// 🔥 Footer
                const Text(
                  "❤️ Made with ",
                  style: TextStyle(color: kPrimaryColorC, fontSize: 20),
                ),
                const Text(
                  "for better healthcare",
                  style: TextStyle(color: kPrimaryColorC, fontSize: 20),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
