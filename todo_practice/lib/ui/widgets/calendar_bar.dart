import 'package:flutter/material.dart';

class CalendarBar extends StatefulWidget {
  const CalendarBar({super.key, required da});

  @override
  State<CalendarBar> createState() => _CalendarBarState();
}

class _CalendarBarState extends State<CalendarBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        children: [
          /// 왼쪽 아이콘
          IconButton(
            icon: const Icon(Icons.calendar_month_sharp),
            onPressed: () {},
          ),

          /// 중앙 텍스트
          const Text(
            ,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          /// 오른쪽 아이콘
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}