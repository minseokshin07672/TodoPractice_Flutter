import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_practice/ui/screens/main_screen.dart';
import 'package:todo_practice/viewModels/main_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: const MainScreen(),
    );
  }
}

