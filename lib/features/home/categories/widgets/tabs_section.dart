import 'package:flutter/material.dart';
import 'package:grad_project/features/home/categories/data/service_provider_profile_model.dart';
import 'package:grad_project/features/home/categories/view/about_service_provider_view.dart';
import 'package:grad_project/features/home/categories/view/location_service_provider_view.dart';
import 'package:grad_project/features/home/categories/view/reviews_service_provider_view.dart';
import 'package:grad_project/features/home/categories/widgets/tab_item.dart';

class TabsSection extends StatefulWidget {
  const TabsSection({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.spModel,
  });

  final double screenWidth;
  final double screenHeight;
  final ServiceProviderProfileModel spModel;

  @override
  State<TabsSection> createState() => _TabsSectionState();
}

class _TabsSectionState extends State<TabsSection> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      AboutServiceProviderView(bio: widget.spModel.bio),
      LocationServiceProviderView(places: widget.spModel.places),
      ReviewsServiceProviderView(spReviews: widget.spModel.spReviews),
    ];

    // double width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Tabs capsule
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0xffE1F2F8),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            children: [
              /// 🔵 الخلفية المتحركة
              AnimatedAlign(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: _getAlignment(selectedIndex),
                child: FractionalTranslation(
                  translation: const Offset(0, 0), // ⬇️ نزول خفيف لتحت
                  child: Container(
                    width: (widget.screenWidth - 32) / 3,
                    height: (widget.screenHeight * 0.056).clamp(40, 100),
                    decoration: BoxDecoration(
                      color: const Color(0xff35AAD5),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
              ),

              /// النصوص
              Row(
                children: [
                  TabItem(
                    screenHeight: widget.screenHeight,
                    screenWidth: widget.screenWidth,
                    title: "نبذة تعريفية",
                    isSelected: selectedIndex == 0,
                    onTap: () => setState(() => selectedIndex = 0),
                  ),
                  TabItem(
                    screenHeight: widget.screenHeight,
                    screenWidth: widget.screenWidth,
                    title: "الموقع",
                    isSelected: selectedIndex == 1,
                    onTap: () => setState(() => selectedIndex = 1),
                  ),
                  TabItem(
                    screenHeight: widget.screenHeight,
                    screenWidth: widget.screenWidth,
                    title: "التقييمات",
                    isSelected: selectedIndex == 2,
                    onTap: () => setState(() => selectedIndex = 2),
                  ),
                ],
              ),
            ],
          ),
        ),

        /// المحتوى
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: pages[selectedIndex],
        ),
      ],
    );
  }

  Alignment _getAlignment(int index) {
    switch (index) {
      case 0:
        return Alignment.centerRight;
      case 1:
        return Alignment.center;
      case 2:
        return Alignment.centerLeft;
      default:
        return Alignment.center;
    }
  }
}
