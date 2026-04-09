import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_state.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/app_bar.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/button.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/card.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/header.dart';

class AddCountry extends StatefulWidget {
  const AddCountry({super.key});

  @override
  State<AddCountry> createState() => _AddCountryState();
}

class _AddCountryState extends State<AddCountry> {
  final List<String> _allCenters = [
    "سوهاج",
    "أخميم",
    "البلينا",
    "المراغة",
    "المنشأة",
    "دار السلام",
    "جرجا",
    "جهينة",
    "ساقلتة",
    "طما",
    "طهطا",
    "حي الكوثر",
    "العسيرات",
  ];

  final Set<String> _selectedCenters = {};
  bool _isInitialized = false;

  void _toggleCenter(String center) {
    setState(() {
      if (_selectedCenters.contains(center)) {
        _selectedCenters.remove(center);
      } else {
        _selectedCenters.add(center);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GitSPCubit, GitSPState>(
      builder: (context, state) {
        if (state is GitSPSuccess && !_isInitialized) {
          // ملء المراكز المختارة من الـ API
          if (state.profile.doctorServiceAreas != null) {
            for (var area in state.profile.doctorServiceAreas!) {
              _selectedCenters.add(area.name);
            }
          }
          _isInitialized = true;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Column(
                children: [
                  const MyAppBar(),
                  const MyHeader(),
                  Expanded(
                    child: Stack(
                      children: [
                        ListView.builder(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
                          itemCount: _allCenters.length,
                          itemBuilder: (context, index) {
                            final center = _allCenters[index];
                            return MyCard(
                              title: center,
                              isSelected: _selectedCenters.contains(center),
                              onTap: () => _toggleCenter(center),
                            );
                          },
                        ),
                        MyButton(
                          isVisible: _selectedCenters.isNotEmpty,
                          onPressed: () {
                            // منطق الحفظ يمكن إضافته هنا
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
