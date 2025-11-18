import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/main_viewmodel.dart';

class CalendarItem extends StatelessWidget {
  final bool todoExist;
  final DateTime date;
  final VoidCallback onTap;

  const CalendarItem({
    super.key,
    required this.todoExist,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final selected = viewModel.selectedDate;

    final now = DateTime.now();
    final isToday = now.year == date.year &&
        now.month == date.month &&
        now.day == date.day;

    final isSelected = selected.year == date.year &&
        selected.month == date.month &&
        selected.day == date.day;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (todoExist)
                  Icon(Icons.square_rounded, size: 20, color: Colors.grey),
                if (isToday && !todoExist)
                  Icon(Icons.square_rounded, size: 20, color: Colors.black),
                if (isSelected)
                  Icon(Icons.check_box_outline_blank_rounded, size: 20, color: Colors.black),
                if (!todoExist && !isToday && !isSelected)
                  Icon(Icons.check_box_outline_blank_rounded, size: 20, color: Colors.black12),
              ],
            ),
          ),
          Text(date.day.toString(), style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}