import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/ui/widgets/todo_board.dart';

import '../../viewModels/main_viewmodel.dart';
import '../widgets/calendar_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CalendarBar(
                yyyymmdd: 20251118,
                todo: viewModel.todoCount,
                done: viewModel.doneCount,
              ),

              const SizedBox(height: 16),
              TodoBoard(
                todos: viewModel.sortedTodos,
                onTodoTap: viewModel.toggle,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}
