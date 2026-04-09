import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/patient/features/home/presentation/widgets/theme_toggle.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_state.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/updata_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/updata_s_p_state.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/custom_phone_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/number_input_field.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/section_title.dart';
import 'package:grad_project/service_provider/features/requests/repos/Service_profile_Repo.dart';

class EditSPView extends StatefulWidget {
  const EditSPView({super.key});

  @override
  State<EditSPView> createState() => _EditSPViewState();
}

class _EditSPViewState extends State<EditSPView> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GitSPCubit(SPProfileRepoImpl(getIt<ApiConsumer>()))
                ..getProviderProfile(),
        ),
        BlocProvider(
          create: (context) =>
              UpdataSPCubit(SPProfileRepoImpl(getIt<ApiConsumer>())),
        ),
      ],
      child: const _EditSPContent(),
    );
  }
}

class _EditSPContent extends StatefulWidget {
  const _EditSPContent();

  @override
  State<_EditSPContent> createState() => _EditSPContentState();
}

class _EditSPContentState extends State<_EditSPContent> {
  bool isAvailable = true;
  bool isInitialized = false;

  File? _pickedImage;
  final ImagePicker _picker = ImagePicker();

  String? _localFirstName;
  String? _localLastName;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  late TextEditingController _priceController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneController = TextEditingController();
    _priceController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _priceController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (picked != null) {
        setState(() {
          _pickedImage = File(picked.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _showEditNameDialog(
    String initialFirst,
    String initialLast,
  ) async {
    _firstNameController.text = initialFirst;
    _lastNameController.text = initialLast;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('تعديل الاسم'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'الاسم الأول'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'اسم العائلة'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _localFirstName = _firstNameController.text.trim().isEmpty
                      ? null
                      : _firstNameController.text.trim();
                  _localLastName = _lastNameController.text.trim().isEmpty
                      ? null
                      : _lastNameController.text.trim();
                });
                Navigator.pop(context);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdataSPCubit, UpdataSPState>(
      listener: (context, updateState) {
        if (updateState is UpdataSPSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('تم تحديث البيانات بنجاح')),
          );

          // ✅ استدعاء الجيت عشان يعمل refresh للبيانات
          context.read<GitSPCubit>().getProviderProfile();

          // ✅ رجوع للصفحة السابقة (البروفايل)
          Navigator.pop(context);
        } else if (updateState is UpdataSPFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(updateState.errMessage)));
        }
      },

      builder: (context, updateState) {
        return BlocBuilder<GitSPCubit, GitSPState>(
          builder: (context, state) {
            if (state is GitSPSuccess) {
              final profile = state.profile;
              if (!isInitialized) {
                isAvailable = profile.isActive ?? true;
                isInitialized = true;

                _localFirstName = profile.firstName;
                _localLastName = profile.lastName;
                _firstNameController.text = _localFirstName ?? '';
                _lastNameController.text = _localLastName ?? '';
                _phoneController.text = profile.phoneNumber ?? '';
                _priceController.text = profile.price?.toString() ?? '';
                _bioController.text = profile.bio ?? '';
              }

              return Scaffold(
                appBar: AppBar(
                  title: const ThemeToggleApp(),
                  elevation: 0,
                  automaticallyImplyLeading: false,
                ),
                body: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            backgroundImage: _pickedImage != null
                                ? FileImage(_pickedImage!)
                                : (profile.image != null
                                      ? NetworkImage(profile.image!)
                                      : const AssetImage(
                                          'assets/images/tempphoto.png',
                                        )),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: _pickFromGallery,
                              child: const CircleAvatar(
                                radius: 12,
                                backgroundColor: Color(0xFF35AAD5),
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 14,
                                  color: Colors.white,
                                ),
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
                            '${_localFirstName ?? profile.firstName ?? ''} ${_localLastName ?? profile.lastName ?? ''}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F3E6C),
                            ),
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () => _showEditNameDialog(
                              _localFirstName ?? profile.firstName ?? '',
                              _localLastName ?? profile.lastName ?? '',
                            ),
                            child: const Icon(
                              Icons.edit_outlined,
                              size: 15,
                              color: Color(0xFF1F3E6C),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      const SectionTitle(title: 'البيانات الأساسية'),
                      const SizedBox(height: 12),
                      CustomPhoneField(
                        controller: _phoneController,
                        hint: 'رقم التليفون',
                        icon: Icons.phone_outlined,
                      ),
                      const SizedBox(height: 20),
                      const SectionTitle(title: 'المعلومات المهنية'),
                      const SizedBox(height: 12),
                      NumberInputField(
                        controller: _priceController,
                        icon: Icons.credit_card,
                        hint: 'سعر الكشف',
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.push(
                            '/add_country',
                            extra: {
                              'gitCubit': context.read<GitSPCubit>(),
                              'updateCubit': context.read<UpdataSPCubit>(),
                            },
                          );
                        },
                        style: _buttonStyle(),
                        child: const Text('إضافة المراكز'),
                      ),
                      const SizedBox(height: 24),
                      const SectionTitle(title: 'حالة التوفر'),
                      const SizedBox(height: 8),
                      ToggleButtons(
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
                      const SizedBox(height: 20),
                      const SectionTitle(title: 'نبذة عن الطبيب'),
                      const SizedBox(height: 8),
                      TextField(
                        maxLines: 4,
                        controller: _bioController,
                        decoration: InputDecoration(
                          hintText: 'اكتب نبذة مختصرة عن خبرتك الطبية...',
                          hintStyle: const TextStyle(
                            color: Color(0xFF9C9C9C),
                            fontSize: 14,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Color(0xFF9C9C9C),
                            ),
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
                        onPressed: updateState is UpdataSPLoading
                            ? null
                            : () {
                                final firstName =
                                    _localFirstName ?? profile.firstName ?? '';
                                final lastName =
                                    _localLastName ?? profile.lastName ?? '';
                                final phone = _phoneController.text.trim();
                                final price =
                                    double.tryParse(
                                      _priceController.text.trim(),
                                    ) ??
                                    profile.price ??
                                    0;
                                final bio = _bioController.text.trim();
                                final selectedAreaIds =
                                    profile.doctorServiceAreas
                                        ?.map((area) => area.id)
                                        .toList() ??
                                    [];

                                context.read<UpdataSPCubit>().updateProfile(
                                  firstName: firstName,
                                  lastName: lastName,
                                  phoneNumber: phone,
                                  latitude: profile.latitude ?? 0,
                                  longitude: profile.longitude ?? 0,
                                  price: price,
                                  isActive: isAvailable,
                                  bio: bio,
                                  image: _pickedImage,
                                );
                              },
                        style: _buttonStyle(),
                        child: updateState is UpdataSPLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'حفظ التعديلات',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
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
        if (states.contains(WidgetState.pressed)) {
          return const Color(0xFF1F3E6C);
        }
        return null;
      }),
    );
  }
}
