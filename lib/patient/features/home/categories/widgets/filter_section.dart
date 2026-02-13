import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/patient/features/home/categories/view_model/filter_cubit/filter_cubit.dart';
import 'package:grad_project/patient/features/home/categories/widgets/filter_item.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({super.key, required this.screenHeight, required this.filterList});
  final double screenHeight;
  final List<String> filterList;

  @override
  Widget build(BuildContext context) {
    if (filterList.isEmpty) return const SizedBox();
    return SizedBox(
      height: (screenHeight * 0.05).clamp(30, 60),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filterList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: FilterItem(
              text: filterList[index],
              onRemove: () {
                context.read<FilterCubit>().removeFilter(filterList[index]);
              },
            ),
          );
        },
      ),
    );
  }
}