import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/categories/view_model/filter_cubit/filter_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_providers_list_cubit/service_providers_list_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/filter_section.dart';
import 'package:grad_project/patient/features/home/categories/widgets/service_provider_list_section.dart';

class ServiceProviderViewBody extends StatefulWidget {
  const ServiceProviderViewBody({super.key, required this.cName});
  final String cName;

  @override
  State<ServiceProviderViewBody> createState() =>
      _ServiceProviderViewBodyState();
}

class _ServiceProviderViewBodyState extends State<ServiceProviderViewBody> {
  late ScrollController controller;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = ScrollController();

    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        context.read<ServiceProvidersListCubit>().loadMore();
      }
    });

    context.read<ServiceProvidersListCubit>().init(widget.cName);
  }

  void applyFilters(FilterState filterState) {
    double? min;
    double? max;
    int? genderValue;
  

    // 🔥 تحويل الجندر لـ enum (1 أو 2)
    if (filterState.selectedGender != null) {
      genderValue = filterState.selectedGender == "ذكر" ? 1 : 2;
    }

    // 🔥 price parsing
    if (filterState.selectedPriceRange != null) {
      var parts = filterState.selectedPriceRange!.split("-");
      max = double.tryParse(parts[0]);
      min = double.tryParse(parts[1].split(" ").first);
      log("min $min , max $max");
    }



    context.read<ServiceProvidersListCubit>().updateFilters(
      gender: genderValue, 
      area: filterState.selectedLocation,
      minPrice: min,
      maxPrice: max,
      search: searchController.text,

    );
  }
  
  @override
  void dispose() {
   controller.dispose();
   searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<FilterCubit, FilterState>(
      listener: (context, filterState) {
        applyFilters(filterState); // 🔥
      },
      child: BlocBuilder<FilterCubit, FilterState>(
        builder: (context, state) {
          final cubit = context.read<FilterCubit>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          onSubmitted: (_) => applyFilters(state), // 🔥 search
                          decoration: InputDecoration(
                            hintText: "ابحث",
                            prefixIcon: const Icon(Icons.search),
                            border: buildBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      PopupMenuButton<String>(
                        icon: SvgPicture.asset("assets/images/align-left.svg"),
                        onSelected: (value) {
                          if (value == "السعر") {
                            showDialog(
                              context: context,
                              builder: (_) => PriceFilterDialog(
                                onSave: (val) {
                                  cubit.updateFilter("السعر", val);
                                },
                              ),
                            );
                          } else if (value == "النوع") {
                            showDialog(
                              context: context,
                              builder: (_) => GenderFilterDialog(
                                onSelect: (val) {
                                  cubit.updateFilter("النوع", val);
                                },
                              ),
                            );
                          } else if (value == "المركز") {
                            showDialog(
                              context: context,
                              builder: (_) => LocationFilterDialog(
                                onSelect: (val) {
                                  cubit.updateFilter("المركز", val);
                                },
                              ),
                            );
                          }
                        },
                        itemBuilder: (context) => [
                          _buildPopupMenuItem(
                            "السعر",
                            state.selectedPriceRange != null,
                          ),
                          _buildPopupMenuItem(
                            "النوع",
                            state.selectedGender != null,
                          ),
                          _buildPopupMenuItem(
                            "المركز",
                            state.selectedLocation != null,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                FilterSection(
                  screenHeight: screenHeight,
                  filterList: state.activeFilters,
                ),

                Expanded(
                  child:
                      BlocBuilder<
                        ServiceProvidersListCubit,
                        ServiceProvidersListState
                      >(
                        builder: (context, state) {
                          if (state is ServiceProvidersListSuccess) {
                            return state.doctorSModelList.isEmpty
                                ? Center(child: Text("لا يتوفر مقدمي خدمه"))
                                : ServiceProviderListSection(
                                    doctorModelList: state.doctorSModelList,
                                    screenWidth: screenWidth,
                                    screenHeight: screenHeight,
                                    controller: controller,
                                    isLoadingMore: state.isLoadingMore,
                                  );
                          } else if (state is ServiceProvidersListFaliure) {
                            return Center(child: Text(state.errorMsg));
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppTheme.brandColor(context),
                              ),
                            );
                          }
                        },
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String title, bool isSelected) {
    return PopupMenuItem<String>(
      value: title,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontFamily: "Tajawal")),
          if (isSelected)
            const Icon(Icons.check_circle, color: kPrimaryColorC, size: 20),
        ],
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: kPrimaryColorC, width: 1.5),
    );
  }
}

// --- الـ Dialogs مع تعديل منطق الـ Toggle ---

class GenderFilterDialog extends StatelessWidget {
  final Function(String) onSelect;
  const GenderFilterDialog({super.key, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surfaceContainer(context), //Color(0xffE1F2F8),
      title: const Text(
        "اختر النوع",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Tajawal"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: const Text("ذكر", textAlign: TextAlign.right),
            onTap: () {
              onSelect("ذكر");
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text("أنثى", textAlign: TextAlign.right),
            onTap: () {
              onSelect("أنثى");
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class LocationFilterDialog extends StatelessWidget {
  final Function(String) onSelect;
  const LocationFilterDialog({super.key, required this.onSelect});

  static const List<String> centers = [
    "أخميم",
    "طهطا",
    "طما",
    "المراغة",
    "ساقلتة",
    "المنشاة",
    "جرجا",
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppTheme.surfaceContainer(context), //Color(0xffE1F2F8),
      title: const Text(
        "اختر المركز",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Tajawal"),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: centers.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(centers[index], textAlign: TextAlign.right),
            onTap: () {
              onSelect(centers[index]);
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}

class PriceFilterDialog extends StatelessWidget {
  final Function(String) onSave;
  const PriceFilterDialog({super.key, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final TextEditingController minController = TextEditingController();
    final TextEditingController maxController = TextEditingController();

    return AlertDialog(
      backgroundColor: AppTheme.surfaceContainer(
        context,
      ), //const Color(0xffE1F2F8),
      title: const Text(
        "نطاق السعر",
        textAlign: TextAlign.center,
        style: TextStyle(fontFamily: "Tajawal"),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: minController,
                  decoration: const InputDecoration(hintText: "من"),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: maxController,
                  decoration: const InputDecoration(hintText: "إلى"),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            // 1. التأكد أن الحقول ليست فارغة
            if (minController.text.isNotEmpty &&
                maxController.text.isNotEmpty) {
              // 2. تحويل النص إلى أرقام للمقارنة
              double? min = double.tryParse(minController.text);
              double? max = double.tryParse(maxController.text);

              if (min != null && max != null) {
                if (min < max) {
                  // القيمة صحيحة
                  onSave("${maxController.text}-${minController.text} ج.م");
                  Navigator.pop(context);
                } else {
                  // السعر "من" أكبر من "إلى"
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("يجب أن يكون سعر 'من' أقل من سعر 'إلى'"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            } else {
              // حقول فارغة
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("يرجى إدخال نطاق السعر كاملاً"),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
          child: const Text("حفظ", style: TextStyle(fontFamily: "Tajawal")),
        ),
      ],
    );
  }
}
