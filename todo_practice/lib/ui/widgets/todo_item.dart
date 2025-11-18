import 'package:flutter/material.dart';

import '../../models/todo.dart';

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
            Icon(
              isDone
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              size: 18,
              color: isDone ? Colors.black : Colors.grey,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                todo.task,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
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
