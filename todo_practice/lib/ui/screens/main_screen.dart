import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/ui/widgets/todo_board.dart';

import '../../viewModels/main_viewmodel.dart';
import '../theme/app_colors.dart';
import '../widgets/add_todo_modal.dart';
import '../widgets/calendar_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      backgroundColor: AppColors.greyBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CalendarBar(),
              const SizedBox(height: 16),
              Flexible(
                child: TodoBoard(
                  todos: viewModel.filteredTodos,
                  onTodoTap: viewModel.toggle,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddTodoModal(),
          );
        },
        tooltip: 'Add Todo',
        backgroundColor: Colors.white,
        foregroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}
