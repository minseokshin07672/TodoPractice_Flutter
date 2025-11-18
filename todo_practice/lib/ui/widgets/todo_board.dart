import 'package:flutter/material.dart';
import '../../models/todo.dart';
import 'todo_item.dart';

class TodoBoard extends StatelessWidget {
  final List<Todo> todos;
  final Function(Todo todo) onTodoTap;

  const TodoBoard({
    super.key,
    required this.todos,
    required this.onTodoTap,
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
            todo: todo,
            onTap: () => onTodoTap(todo),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 11),
      ),
    );
  }
}