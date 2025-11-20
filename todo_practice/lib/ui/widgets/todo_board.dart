import 'package:flutter/material.dart';

import '../../domain/models/todo.dart';
import 'todo_item.dart';

class TodoBoard extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo todo) onTodoTap;
  final Function(Todo todo) onTodoDelete;

  const TodoBoard({
    super.key,
    required this.todos,
    required this.onTodoTap,
    required this.onTodoDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return TodoItem(
            key: ValueKey(todo.hashCode),
            todo: todo,
            index: index,
            onTap: () => onTodoTap(todo),
            onDelete: () => onTodoDelete(todo),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 11),
      ),
    );
  }
}
