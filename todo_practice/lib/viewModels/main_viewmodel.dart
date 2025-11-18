import 'package:flutter/material.dart';
import 'package:todo_practice/models/todo.dart';

class MainViewModel extends ChangeNotifier {
  List<Todo> todos = [
    Todo(done: false, task: "운동하기", dueDate: DateTime(2025, 11, 18)),
    Todo(done: true, task: "요리 연습하기", dueDate: DateTime(2025, 11, 20)),
    Todo(done: false, task: "프로젝트 코드 정리하기", dueDate: DateTime(2025, 11, 22)),
    Todo(
      done: false,
      task: "긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트",
      dueDate: DateTime(2025, 11, 18),
    ),
  ];

  void toggle(Todo todo) {
    final index = todos.indexOf(todo);
    if (index == -1) return;
    todos[index] = todo.copyWith(done: !todo.done);
    notifyListeners();
  }

  List<Todo> get sortedTodos {
    final undone = todos.where((t) => !t.done).toList();
    final done = todos.where((t) => t.done).toList();
    return [...undone, ...done];
  }

  int get doneCount => todos.where((t) => t.done).length;

  int get todoCount => todos.where((t) => !t.done).length;
}
