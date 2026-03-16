import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grad_project/core/helper/reusable_dialog.dart';
import 'package:grad_project/core/utils/map/location_services.dart';
import 'package:grad_project/service_provider/features/auth/presentation/views/step3_view.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_bottom_sheet.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_botton2.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_text_field3.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/custom_textfield4.dart';
import 'package:grad_project/service_provider/features/auth/presentation/widgets/step3_view_body.dart';
import 'package:grad_project/patient/features/authentication/presentation/widgets/steps.dart';
import 'package:grad_project/service_provider/features/auth/data/s_p_regester_model.dart';
import 'package:grad_project/service_provider/features/auth/presentation/view_model/sp_register_cubit/sp_register_cubit.dart';

class Step2ViewBody extends StatefulWidget {
  const Step2ViewBody({super.key});

  @override
  State<Step2ViewBody> createState() => _Step2ViewState();
}

class _Step2ViewState extends State<Step2ViewBody> {
  final TextEditingController locationController = TextEditingController();
  final TextEditingController specialtyController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  double? lat;
  double? long;
  GlobalKey<FormState> formKey = GlobalKey();

  Future<void> getLocation() async {
    try {
      // جلب الموقع باستخدام LocationService
      final locationData = await LocationService().getLocationData();

      lat = locationData["lat"];
      long = locationData["long"];

      // تحديث الـ TextField بالعناوين
      locationController.text = locationData["address"];
    } on LocationServiceException {
      // GPS مغلق
    showDialog(
  context: context,
  builder: (context) => ReusableDialog(
    title: "خدمة الموقع مغلقة",
    content: "يجب تفعيل GPS على جهازك لتحديد الموقع.",
  ),
);
    } on LocationPermissionException {
      // صلاحية الموقع مرفوضة
    showDialog(
  context: context,
  builder: (context) => ReusableDialog(
    title: "صلاحية الموقع مرفوضة",
    content:  "يجب السماح للتطبيق بالوصول إلى الموقع لتحديد موقعك.",
  ),
);


    } catch (e) {
  showDialog(
  context: context,
  builder: (context) => ReusableDialog(
    title: "حدث خطأ",
    content: e.toString(),
  ),
);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/medicall2(1)(1).png",
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 25),

                Steps(num: 2),

                const SizedBox(height: 140),

                /// LOCATION FIELD
                CustomTextField4(
                  hintText: 'الموقع',
                  suffixIcon: Icons.location_on,
                  controller: locationController,
                  onSuffixTap: () async {
                    await getLocation();
                  },
                ),

                const SizedBox(height: 12),

                /// SPECIALTY
                CustomTextField4(
                  hintText: 'التخصص',
                  suffixIcon: Icons.arrow_forward_ios_rounded,
                  isExpanded: true,
                  controller: specialtyController,
                  onSuffixTap: () {
                    showSelectionBottomSheet(
                      context: context,
                      items: [
                        'طب عام',
                        'أسنان',
                        'جلدية',
                        'أطفال',
                        'عظام',
                        "تمريض منزلي",
                      ],
                      onSelect: (value) {
                        specialtyController.text = value;
                        setState(() {});
                      },
                    );
                  },
                ),

                const SizedBox(height: 12),

                /// GENDER
                CustomTextField4(
                  hintText: 'النوع',
                  suffixIcon: Icons.arrow_forward_ios_rounded,
                  isExpanded: true,
                  controller: genderController,
                  onSuffixTap: () {
                    showSelectionBottomSheet(
                      context: context,
                      items: ['ذكر', 'أنثى'],
                      onSelect: (value) {
                        genderController.text = value;
                      },
                    );
                  },
                ),

                const SizedBox(height: 12),

                specialtyController.text.isNotEmpty &&
                        specialtyController.text != "تمريض منزلي"
                    ? CustomTextField3(
                        controller: priceController,
                        hintText: 'سعر الكشف (ج.م)',
                        suffixIcon: Icons.wallet,
                        keyboardType: TextInputType.numberWithOptions(),
                      )
                    : SizedBox(),
                const SizedBox(height: 80),

                Row(
                  children: [
                    CustomButton2(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      text: 'رجوع',
                    ),

                    const Spacer(),

                    CustomButton2(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (lat == null || long == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("من فضلك حدد موقعك")),
                            );
                            return;
                          }
                          context.read<SpRegisterCubit>().setProfessionalInfo(
                            specialization: specialtyController.text,
                            price: specialtyController.text == "تمريض منزلي"
                                ? null
                                : double.tryParse(priceController.text),

                            gender: genderController.text == "ذكر"
                                ? Gender.male
                                : Gender.female,
                            lat: lat!,
                            lng: long!,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<SpRegisterCubit>(),
                                child: Step3View(),
                              ),
                            ),
                          );

                      //  Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (_) =>  Step3View(),
                      //         ),
                          
                      //     );

                        }
                      },
                      text: 'التالي',
                    ),
                  ],
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
