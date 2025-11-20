import 'package:flutter/material.dart';

import '../data/todo_local_storage.dart';
import '../domain/models/todo.dart';

class MainViewModel extends ChangeNotifier {
  final TodoLocalStorage _storage = TodoLocalStorage();

  List<Todo> todos = [];
  DateTime selectedDate = DateTime.now();
  bool isCalendarExpanded = false;
  int? openedSwipeIndex;

  MainViewModel() {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    todos = await _storage.loadTodos();
    notifyListeners();
  }

  Future<void> _saveTodos() async {
    await _storage.saveTodos(todos);
  }

  void setOpenedSwipeIndex(int? index) {
    openedSwipeIndex = index;
    notifyListeners();
  }

  void closeAllSwipes() {
    if (openedSwipeIndex != null) {
      openedSwipeIndex = null;
      notifyListeners();
    }
  }

  void toggle(Todo todo) {
    final index = todos.indexOf(todo);
    if (index == -1) return;

    todos[index] = todo.copyWith(
      status: todo.status == TodoStatus.todo
          ? TodoStatus.done
          : TodoStatus.todo,
    );
    _saveTodos();
    notifyListeners();
  }

  void toggleCalendar() {
    isCalendarExpanded = !isCalendarExpanded;
    notifyListeners();
  }

  void setSelectedDay(int day) {
    selectedDate = DateTime(selectedDate.year, selectedDate.month, day);
    notifyListeners();
  }

  void addTodo(String task, DateTime dueDate) {
    todos.add(Todo(status: TodoStatus.todo, task: task, dueDate: dueDate));
    _saveTodos();
    notifyListeners();
  }

  void deleteTodo(Todo todo) {
    todos.remove(todo);
    _saveTodos();
    notifyListeners();
  }

  List<Todo> get filteredTodos {
    final filtered = todos
        .where(
          (t) =>
              t.dueDate.isAtSameMomentAs(selectedDate) ||
              t.dueDate.isAfter(selectedDate),
        )
        .toList();

    final undone = filtered.where((t) => t.status == TodoStatus.todo).toList();
    final done = filtered.where((t) => t.status == TodoStatus.done).toList();

    return [...undone, ...done];
  }

  int get doneCount {
    return filteredTodos.where((t) => t.status == TodoStatus.done).length;
  }

  int get todoCount {
    return filteredTodos.where((t) => t.status == TodoStatus.todo).length;
  }
}
