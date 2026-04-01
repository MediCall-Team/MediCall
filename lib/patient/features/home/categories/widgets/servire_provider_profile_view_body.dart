import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/chach_helper.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_provider_profile/service_provider_profile_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/booking_button.dart';
import 'package:grad_project/patient/features/home/categories/widgets/s_p_data.dart';
import 'package:grad_project/patient/features/home/categories/widgets/tabs_section.dart';

class ServireProviderProfileViewBody extends StatefulWidget {
  const ServireProviderProfileViewBody({super.key, required this.id});
  final int id;

  @override
  State<ServireProviderProfileViewBody> createState() =>
      _ServireProviderProfileViewBodyState();
}

class _ServireProviderProfileViewBodyState
    extends State<ServireProviderProfileViewBody> {
  late ServiceProviderProfileModel spModel;
  late String role;

  @override
  void initState() {


    BlocProvider.of<ServiceProviderProfileCubit>(
      context,
    ).getProviderProfile(id: widget.id);

  role= CacheHelper.getUser()!.role;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return BlocConsumer<ServiceProviderProfileCubit, ServiceProviderProfileState>(
      listener: (context, state) {
        if(state is ServiceProviderProfileSuccess){
          spModel = state.serviceProviderProfileData;
        }
      },
      builder: (context, state) {
        return state is ServiceProviderProfileSuccess?
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SPData(spModel: spModel, screenWidth: screenWidth),
            ),

            SliverToBoxAdapter(
              child: TabsSection(
                id: widget.id,
                spModel: spModel,
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // زر الحجز
                role == "Patient"?  BookingButton(screenWidth: screenWidth):SizedBox(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ):
        Center(child: CircularProgressIndicator(color: AppTheme.brandColor(context),))
        ;
      },
    );
  }
}
