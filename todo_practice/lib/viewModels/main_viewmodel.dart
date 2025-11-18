import 'package:flutter/material.dart';
import 'package:todo_practice/models/todo.dart';

class MainViewModel extends ChangeNotifier {
  List<Todo> todos = [
    Todo(status: TodoStatus.done, task: "월간 계획 세우기", dueDate: DateTime(2025, 11, 1)),
    Todo(status: TodoStatus.done, task: "장보기", dueDate: DateTime(2025, 11, 1)),

    Todo(status: TodoStatus.done, task: "독서 모임 참석", dueDate: DateTime(2025, 11, 3)),

    Todo(status: TodoStatus.done, task: "헬스장 등록", dueDate: DateTime(2025, 11, 5)),
    Todo(status: TodoStatus.done, task: "영어 공부 1시간", dueDate: DateTime(2025, 11, 5)),

    Todo(status: TodoStatus.done, task: "블로그 포스팅", dueDate: DateTime(2025, 11, 7)),

    Todo(status: TodoStatus.done, task: "친구 생일 선물 구매", dueDate: DateTime(2025, 11, 10)),
    Todo(status: TodoStatus.done, task: "자동차 세차", dueDate: DateTime(2025, 11, 10)),

    Todo(status: TodoStatus.done, task: "프로젝트 기획서 작성", dueDate: DateTime(2025, 11, 12)),

    Todo(status: TodoStatus.done, task: "치과 예약", dueDate: DateTime(2025, 11, 14)),
    Todo(status: TodoStatus.done, task: "세금 신고", dueDate: DateTime(2025, 11, 14)),

    Todo(status: TodoStatus.todo, task: "운동하기", dueDate: DateTime(2025, 11, 18)),
    Todo(status: TodoStatus.done, task: "요리 연습하기", dueDate: DateTime(2025, 11, 20)),
    Todo(status: TodoStatus.done, task: "프로젝트 코드 정리하기", dueDate: DateTime(2025, 11, 22)),
    Todo(
      status: TodoStatus.todo,
      task: "긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트 긴 텍스트",
      dueDate: DateTime(2025, 11, 18),
    ),
  ];

  DateTime selectedDate = DateTime.now();

  bool isCalendarExpanded = false;

  void toggle(Todo todo) {
    final index = todos.indexOf(todo);
    if (index == -1) return;

    todos[index] = todo.copyWith(
      status: todo.status == TodoStatus.todo
          ? TodoStatus.done
          : TodoStatus.todo,
    );

    notifyListeners();
  }

  void toggleCalendar(){
    isCalendarExpanded = !isCalendarExpanded;
    notifyListeners();
  }

  void setSelectedDay(int day) {
    selectedDate = DateTime(
      selectedDate.year,
      selectedDate.month,
      day,
    );
    notifyListeners();
  }


  List<Todo> get filteredTodos {
    final filtered = todos
        .where((t) => t.dueDate.isAtSameMomentAs(selectedDate) || t.dueDate.isAfter(selectedDate))
        .toList();

    final undone = filtered.where((t) => t.status == TodoStatus.todo).toList();
    final done = filtered.where((t) => t.status == TodoStatus.done).toList();

    return [...undone, ...done];
  }

  int get doneCount =>
      todos.where((t) => t.status == TodoStatus.done).length;

  int get todoCount =>
      todos.where((t) => t.status == TodoStatus.todo).length;
}