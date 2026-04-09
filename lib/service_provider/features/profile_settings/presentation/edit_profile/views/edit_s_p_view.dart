import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/utils/app_router.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/theme_toggle.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_state.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/Add_country.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/custom_phone_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/custom_text_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/number_input_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/section_title.dart';

class EditSPView extends StatefulWidget {
  const EditSPView({super.key});

  @override
  State<EditSPView> createState() => _EditSPViewState();
}

class _EditSPViewState extends State<EditSPView> {
  bool isAvailable = true;
  bool isInitialized = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GitSPCubit, GitSPState>(
      builder: (context, state) {
        if (state is GitSPSuccess) {
          final profile = state.profile;
          if (!isInitialized) {
            isAvailable = profile.isActive ?? true;
            isInitialized = true;
          }

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              title: ThemeToggleApp(),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundImage: profile.image != null
                            ? NetworkImage(profile.image!)
                            : const AssetImage('assets/images/tempphoto.png')
                                  as ImageProvider,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ' ${profile.firstName ?? ''} ${profile.lastName ?? ''}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F3E6C),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(
                        Icons.edit_outlined,
                        size: 15,
                        color: Color(0xFF1F3E6C),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const SectionTitle(title: 'البيانات الأساسية'),
                  const SizedBox(height: 12),
                  CustomPhoneField(
                    hint: profile.phoneNumber ?? 'رقم التليفون',
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
                  Row(
                    children: [
                      Expanded(
                        child: NumberInputField(
                          icon: Icons.credit_card,
                          hint: profile.price?.toString() ?? 'سعر الكشف',
                        ),
                      ),
                      const SizedBox(width: 12),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      final cubit = context
                          .read<GitSPCubit>(); // هنا ناخد الـ cubit الحالي

                      context.push(
                        '/add_country', // رابط الصفحة الجديدة
                        extra: cubit, // تمرير نفس الـ cubit
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF35AAD5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 32,
                      ),
                    ),
                    child: const Text(
                      'إضافة المراكز',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(title: 'حالة التوفر'),
                      const SizedBox(height: 8),
                      Center(
                        child: ToggleButtons(
                          borderRadius: BorderRadius.circular(20),
                          selectedColor: Colors.white,
                          fillColor: const Color(0xFF35AAD5),
                          color: const Color(0xFF1F3E6C),
                          constraints: const BoxConstraints(
                            minHeight: 40,
                            minWidth: 100,
                          ),
                          isSelected: [!isAvailable, isAvailable],
                          onPressed: (index) {
                            setState(() {
                              isAvailable = index == 1;
                            });
                          },
                          children: const [
                            Text(
                              'غير متاح',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'متاح',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const SectionTitle(title: 'نبذة عن الطبيب'),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 4,
                    controller: TextEditingController(text: profile.bio),
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
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF35AAD5),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 32),
    ).copyWith(
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed))
          return const Color(0xFF1F3E6C);
        return null;
      }),
    );
  }
}
