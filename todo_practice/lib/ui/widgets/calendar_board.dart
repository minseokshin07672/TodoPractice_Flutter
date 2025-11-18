import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/todo.dart';
import '../../viewModels/main_viewmodel.dart';
import 'calendar_item.dart';

class CalendarBoard extends StatefulWidget {
  const CalendarBoard({super.key});

  @override
  State<CalendarBoard> createState() => _CalendarBoardState();
}

class _CalendarBoardState extends State<CalendarBoard> {
  final DateTime _currentMonth = DateTime(2025, 11);

  late final viewModel = context.read<MainViewModel>();

  @override
  Widget build(BuildContext context) {
    final year = _currentMonth.year;
    final month = _currentMonth.month;

    final firstDayOfMonth = DateTime(year, month, 1);
    final daysInMonth = DateTime(year, month + 1, 0).day;

    final firstWeekdayIndex = firstDayOfMonth.weekday - 1;

    final totalCells = firstWeekdayIndex + daysInMonth;
    final weeks = <List<int?>>[];

    int day = 1;
    for (int i = 0; i < totalCells; i++) {
      final weekIndex = i ~/ 7;
      if (weeks.length <= weekIndex) {
        weeks.add(List.filled(7, null));
      }
      final dayIndexInWeek = i % 7;

      if (i < firstWeekdayIndex) {
        weeks[weekIndex][dayIndexInWeek] = null;
      } else {
        weeks[weekIndex][dayIndexInWeek] = day;
        day++;
      }
    }

    const weekdayLabels = ['월', '화', '수', '목', '금', '토', '일'];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: weekdayLabels
              .map(
                (label) => Expanded(
                  child: Center(
                    child: Text(
                      label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        ...weeks.map(
          (week) => Row(
            children: List.generate(7, (index) {
              final day = week[index];

              return Expanded(
                child: day == null
                    ? const SizedBox.shrink()
                    : CalendarItem(
                        date: DateTime(year, month, day),
                        todoExist: _hasDoneTodo(year, month, day),
                        onTap: () {
                          viewModel.setSelectedDay(day);
                        },
                      ),
              );
            }),
          ),
        ),
      ],
    );
  }


  bool _hasDoneTodo(int year, int month, int day) {
    final targetDate = DateTime(year, month, day);
    return viewModel.todos.any((todo) =>
    todo.status == TodoStatus.done &&
        todo.dueDate.year == targetDate.year &&
        todo.dueDate.month == targetDate.month &&
        todo.dueDate.day == targetDate.day);
  }
}



