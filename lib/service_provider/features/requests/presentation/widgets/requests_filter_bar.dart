import 'package:flutter/material.dart';

class RequestsFilterBar extends StatelessWidget {
  final int? selectedStatus;
  final Function(int?) onFilterChanged;

  const RequestsFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filters = {
      null: "الكل",
      1: "قيد المراجعة",
      2: "تمت الموافقة",
      3: "مرفوض",
      4: "مكتمل",
      5: "ملغي",
    };

    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.entries.map((filter) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ChoiceChip(
              label: Text(filter.value),
              selected: selectedStatus == filter.key,
              onSelected: (_) => onFilterChanged(filter.key),
            ),
          );
        }).toList(),
      ),
    );
  }
}