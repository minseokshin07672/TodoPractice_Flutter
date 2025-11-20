import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_practice/ui/theme/app_typography.dart';
import 'package:todo_practice/ui/widgets/styled_text.dart';

import '../../domain/models/todo.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const TodoItem({
    super.key,
    required this.todo,
    required this.onTap,
    required this.onDelete,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  double _dragExtent = 0;
  static const double _deleteButtonWidth = 32;

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        "${widget.todo.dueDate.year}-${widget.todo.dueDate.month.toString().padLeft(2, '0')}-${widget.todo.dueDate.day.toString().padLeft(2, '0')}";

    final isDone = widget.todo.status == TodoStatus.done;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GestureDetector(
        onHorizontalDragUpdate: (details) {
          setState(() {
            _dragExtent += details.delta.dx;
            _dragExtent = _dragExtent.clamp(-_deleteButtonWidth, 0.0);
          });
        },
        onHorizontalDragEnd: (details) {
          setState(() {
            if (_dragExtent < -_deleteButtonWidth / 2) {
              _dragExtent = -_deleteButtonWidth;
            } else {
              _dragExtent = 0;
            }
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: GestureDetector(
                  onTap: widget.onDelete,
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              transform: Matrix4.translationValues(_dragExtent, 0, 0),
              child: GestureDetector(
                onTap: widget.onTap,
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
                          widget.todo.task,
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
                          const Icon(
                            Icons.access_time,
                            size: 16,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
