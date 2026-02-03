import 'package:flutter/material.dart';

void showSelectionBottomSheet({
  required BuildContext context,
  required List<String> items,
  required Function(String) onSelect,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      final maxHeight = MediaQuery.of(context).size.height * 0.5;

      return ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 16),
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                items[index],
                textAlign: TextAlign.right,
                style: const TextStyle(color: Colors.grey),
              ),
              onTap: () {
                onSelect(items[index]);
                Navigator.pop(context);
              },
            );
          },
        ),
      );
    },
  );
}
