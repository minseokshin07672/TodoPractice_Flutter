import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/main_viewmodel.dart';
import '../theme/app_colors.dart';
import 'calendar_board.dart';

class CalendarBar extends StatefulWidget {
  const CalendarBar({super.key});

  @override
  State<CalendarBar> createState() => _CalendarBarState();
}

class _CalendarBarState extends State<CalendarBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();
    final selected = viewModel.selectedDate;

    final now = DateTime.now();
    final isToday =
        now.year == selected.year &&
        now.month == selected.month &&
        now.day == selected.day;

    final dayLabel = "${selected.month}월 ${selected.day}일";

    final todo = viewModel.todoCount;
    final done = viewModel.doneCount;
    final total = todo + done;
    final progress = total == 0 ? 0.0 : done / total;

    return Column(
      children: [
        const SizedBox(height: 72),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  viewModel.toggleCalendar();
                },
                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_sharp,
                      size: 24,
                      color: Colors.black,
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        isToday ? "Today" : dayLabel,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    viewModel.isCalendarExpanded
                        ? Icon(
                            Icons.keyboard_arrow_up,
                            size: 28,
                            color: Colors.black,
                          )
                        : RingProgress(
                            progress: progress,
                            done: done,
                            size: 28,
                            strokeWidth: 4,
                          ),
                  ],
                ),
              ),

              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: viewModel.isCalendarExpanded
                    ? const CalendarBoard()
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RingProgress extends StatelessWidget {
  final double progress;
  final int done;
  final double size;
  final double strokeWidth;
  final Color color;

  const RingProgress({
    super.key,
    required this.progress,
    required this.done,
    this.size = 28,
    this.strokeWidth = 4,
    this.color = AppColors.green,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _RingPainter(
              progress: progress,
              color: color,
              strokeWidth: strokeWidth,
            ),
          ),

          Text(
            done.toString(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final backgroundPaint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final foregroundPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    final sweepAngle = progress * 3.14159 * 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14159 / 2,
      sweepAngle,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) => true;
}
