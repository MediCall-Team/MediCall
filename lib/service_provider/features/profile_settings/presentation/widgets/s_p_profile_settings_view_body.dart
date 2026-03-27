// import 'package:flutter/material.dart';
// import 'package:grad_project/patient/features/home/categories/data/service_provider_profile_model.dart';
// import 'package:grad_project/patient/features/home/categories/widgets/s_p_data.dart';
// import 'package:grad_project/service_provider/features/profile_settings/presentation/widgets/s_tabs_section.dart';

// class SPProfileSettingsViewBody extends StatelessWidget {
//   const SPProfileSettingsViewBody({super.key, required this.spModel});

//   final ServiceProviderProfileModel spModel;
//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     return CustomScrollView(
//       slivers: [
//         SliverToBoxAdapter(
//           child: SPData(spModel: spModel, screenWidth: screenWidth),
//         ),

//         SliverToBoxAdapter(
//           child: STabsSection(
//             spModel: spModel,
//             screenHeight: screenHeight,
//             screenWidth: screenWidth,
//           ),
//         ),

//       ],
//     );
//   }
// }
