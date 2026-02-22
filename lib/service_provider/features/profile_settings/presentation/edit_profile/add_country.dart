import 'package:flutter/material.dart';
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
    'طما',
    'طهطا',
    'جهينة',
    'المراغة',
    'ساقلته',
    'سوهاج',
    'أخميم',
    'المنشأة',
    'العسيرات',
    'جرجا',
    'البلينا',
    'دار السلام',
  ];

  final Set<String> _selectedCenters = {};

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
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
