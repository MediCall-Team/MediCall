import 'package:flutter/material.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/Add_country.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/custom_phone_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/custom_text_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/number_input_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/section_title.dart'; // تأكد من وجود هذا السطر

class EditSPView extends StatefulWidget {
  const EditSPView({super.key});

  @override
  State<EditSPView> createState() => _EditSPViewState();
}

class _EditSPViewState extends State<EditSPView> {
  bool isAvailable = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'إلغاء',
          style: TextStyle(
            color: Color(0xFF9C9C9C),
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),

            /// صورة الطبيب
            Stack(
              children: [
                const CircleAvatar(
                  radius: 45,
                  backgroundImage: AssetImage('assets/images/tempphoto.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 12,
                    backgroundColor: const Color(0xFF35AAD5),
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      size: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// الاسم
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'دكتور. مريم محمد',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F3E6C),
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.edit_outlined, size: 15, color: Color(0xFF1F3E6C)),
              ],
            ),

            const SizedBox(height: 30),

            /// البيانات الأساسية
            const SectionTitle(title: 'البيانات الأساسية'),
            const SizedBox(height: 12),
            const CustomPhoneField(
              hint: 'رقم التليفون',
              icon: Icons.phone_outlined,
            ),
            const SizedBox(height: 12),
            const CustomTextField(
              hint: 'موقع',
              icon: Icons.location_on_outlined,
            ),

            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 320,
                    height: 1,
                    color: const Color(0xFFD9D9D9),
                    margin: const EdgeInsets.only(bottom: 16),
                  ),
                ),
                const SectionTitle(title: 'المعلومات المهنية'),
              ],
            ),
            const SizedBox(height: 12),

            /// حقول سعر الكشف وسنوات الخبرة - (تم حذف const من هنا)
            Row(
              children: const [
                Expanded(
                  child: NumberInputField(
                    icon: Icons.credit_card,
                    hint: 'سعر الكشف',
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: NumberInputField(
                    icon: Icons.calendar_today,
                    hint: 'سنوات الخبرة',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCountry()),
                );
              },
              style: _buttonStyle(),
              child: const Text(
                'إضافة المراكز',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),

            const SizedBox(height: 24),

            /// حالة التوفر
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle(title: 'حالة التوفر'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'غير متاح',
                      style: TextStyle(
                        color: !isAvailable
                            ? const Color(0xFF35AAD5)
                            : const Color(0xFF1F3E6C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Transform.scale(
                        scaleX: 1.2,
                        scaleY: 0.6,
                        child: Switch(
                          value: isAvailable,
                          onChanged: (value) {
                            setState(() {
                              isAvailable = value;
                            });
                          },
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF35AAD5),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade300,
                          trackOutlineColor: WidgetStateProperty.all(
                            Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'متاح',
                      style: TextStyle(
                        color: isAvailable
                            ? const Color(0xFF35AAD5)
                            : const Color(0xFF1F3E6C),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            const SectionTitle(title: 'نبذة عن الطبيب'),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'اكتب نبذة مختصرة عن خبرتك الطبية...',
                hintStyle: const TextStyle(
                  color: Color(0xFF9C9C9C),
                  fontSize: 14,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF9C9C9C)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color(0xFF35AAD5),
                    width: 1.5,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {},
              style: _buttonStyle(),
              child: const Text(
                'حفظ التعديلات',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF35AAD5),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
      minimumSize: const Size(0, 0),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed))
          return const Color(0xFF1F3E6C);
        return null;
      }),
    );
  }
}
