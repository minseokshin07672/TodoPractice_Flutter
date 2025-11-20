import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../domain/models/todo.dart';

class TodoLocalStorage {
  static const String _key = 'todos';

  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key) ?? '[]';
    final List<dynamic> decoded = jsonDecode(jsonString);
    return decoded
        .map((json) => Todo.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = todos.map((t) => t.toJson()).toList();
    await prefs.setString(_key, jsonEncode(jsonList));
  }
}
