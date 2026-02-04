import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/patient/features/home/categories/view_model/location_cubit/location_cubit_cubit.dart';

import 'package:grad_project/patient/features/home/categories/widgets/location_chip.dart';
import 'package:grad_project/patient/features/home/categories/widgets/location_map_view.dart';
import 'package:lottie/lottie.dart';

class SLocationServiceProviderView extends StatelessWidget {
  const SLocationServiceProviderView({super.key, required this.places});

  final List<String>places;
  // static const List<String> places = [
  //   "أخميم",
  //   "جرجا",
  //   "المراغه",
  //   "طهطا",
  //   "المنشأة",
  //   "ساقلته"
  // ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (_) => LocationCubitCubit()..fetchLocations(places),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              "الموقع",
              style: TextStyle(
                fontSize: (screenWidth * 0.045).clamp(12, 30),
                fontWeight: FontWeight.bold,
                fontFamily: "Tajawal",
                color: kPrimaryColorC,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
              //  color: const Color.fromARGB(96, 225, 242, 248),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Wrap(
                spacing: 10.0,
                runSpacing: 12.0,
                children: places
                    .map((place) => LocationChip(
                        screenWidth: screenWidth, placeName: place))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 16),
            child: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    final cubit = context.read<LocationCubitCubit>();
                    final state = cubit.state;

                    if (state is LocationCubitSuccess) {
                      // تم التحميل بنجاح -> انتقل
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LocationMapView(
                            locations: state.locations,
                            places: places,
                          ),
                        ),
                      );
                    } else if (state is LocationCubitLoading) {
                      // لسه بيحمل -> أظهر رسالة بسيطة أو Loading مؤقت
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("جاري تحضير الخريطة... انتظر لحظة"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else if (state is LocationCubitFailure) {
                      // فشل -> أعد المحاولة
                      cubit.fetchLocations(places);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMsg)),
                      );
                    }
                  },
                  child: LottieBuilder.asset("assets/animation/ubicacin.json"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}