import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/utils/api/api_consumer.dart';
import 'package:grad_project/core/utils/get_it.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/Git_S_P_cubit/git_s_p_state.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/add_country_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/add_country_s_p_state.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/cubit/updata_s_p_cubit.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/app_bar.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/button.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/card.dart';
import 'package:grad_project/service_provider/features/profile_settings/presentation/edit_profile/widget/header.dart';
import 'package:grad_project/service_provider/features/requests/repos/Service_profile_Repo.dart';

class AddCountry extends StatelessWidget {
  final GitSPCubit gitCubit;
  final UpdataSPCubit updateCubit;

  const AddCountry({
    super.key,
    required this.gitCubit,
    required this.updateCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: gitCubit),
        BlocProvider.value(
          value: updateCubit,
        ), // ✅ نفس الكيوبت اللي جاي من EditSPView
        BlocProvider(
          create: (context) =>
              AddCountrySPCubit(SPProfileRepoImpl(getIt<ApiConsumer>())),
        ),
      ],
      child: const _AddCountryContent(),
    );
  }
}

class _AddCountryContent extends StatefulWidget {
  const _AddCountryContent();

  @override
  State<_AddCountryContent> createState() => _AddCountryContentState();
}

class _AddCountryContentState extends State<_AddCountryContent> {
  final Map<String, int> _centerIds = {
    "سوهاج": 1,
    "أخميم": 2,
    "البلينا": 3,
    "المراغة": 4,
    "المنشأة": 5,
    "دار السلام": 6,
    "جرجا": 7,
    "جهينة": 8,
    "ساقلتة": 9,
    "طما": 10,
    "طهطا": 11,
    "حي الكوثر": 12,
    "العسيرات": 13,
  };

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
    return BlocListener<AddCountrySPCubit, AddCountrySPState>(
      listener: (context, state) {
        if (state is AddCountrySPSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));

          // ✅ خزّن المراكز في UpdataSPCubit قبل الرجوع
          final ids = _selectedCenters.map((e) => _centerIds[e]!).toList();
          context.read<UpdataSPCubit>().setAreas(ids);

          Navigator.pop(context);
        } else if (state is AddCountrySPError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<GitSPCubit, GitSPState>(
        builder: (context, state) {
          if (state is GitSPSuccess && !_isInitialized) {
            if (state.profile.doctorServiceAreas != null) {
              for (var area in state.profile.doctorServiceAreas!) {
                _selectedCenters.add(area.name);
              }
            }
            _isInitialized = true;
          }

          return Scaffold(
          //  backgroundColor: Colors.white,
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
                            itemCount: _centerIds.length,
                            itemBuilder: (context, index) {
                              final center = _centerIds.keys.toList()[index];
                              return MyCard(
                                title: center,
                                isSelected: _selectedCenters.contains(center),
                                onTap: () => _toggleCenter(center),
                              );
                            },
                          ),
                          BlocBuilder<AddCountrySPCubit, AddCountrySPState>(
                            builder: (context, state) {
                              final isLoading = state is AddCountrySPLoading;

                              return MyButton(
                                isVisible: _selectedCenters.isNotEmpty,
                                onPressed: () {
                                  if (isLoading) return;
                                  final ids = _selectedCenters
                                      .map((e) => _centerIds[e]!)
                                      .toList();
                                  context.read<AddCountrySPCubit>().addAreas(
                                    ids,
                                  );
                                },
                              );
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
      ),
    );
  }
}
