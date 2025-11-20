import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_practice/ui/theme/app_typography.dart';
import 'package:todo_practice/ui/widgets/styled_text.dart';

import '../../domain/models/todo.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback onTap;

  const TodoItem({super.key, required this.todo, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        "${todo.dueDate.year}-${todo.dueDate.month.toString().padLeft(2, '0')}-${todo.dueDate.day.toString().padLeft(2, '0')}";

    final isDone = todo.status == TodoStatus.done;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isDone
                  ? "assets/ic_checkbox_checked.svg"
                  : "assets/ic_checkbox_unchecked.svg",
              width: 18,
              height: 18,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: styledText(
                todo.task,
                testStyle: AppTypography.bodySmall.copyWith(
                  decoration: isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: isDone ? Colors.grey : Colors.black,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
