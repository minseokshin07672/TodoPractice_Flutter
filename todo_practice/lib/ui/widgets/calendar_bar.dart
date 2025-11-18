import 'package:flutter/material.dart';

class CalendarBar extends StatefulWidget {
  final int yyyymmdd;
  final int todo;
  final int done;

  const CalendarBar({
    super.key,
    required this.yyyymmdd,
    required this.todo,
    required this.done,
  });

  @override
  State<CalendarBar> createState() => _CalendarBarState();
}

class _CalendarBarState extends State<CalendarBar> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final todayKey = now.year * 10000 + now.month * 100 + now.day;

    final isToday = widget.yyyymmdd == todayKey;

    final int day = widget.yyyymmdd % 100;

    final int total = widget.todo + widget.done;
    final double progress = total == 0 ? 0 : widget.done / total;

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

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.calendar_month_sharp,
                size: 24,
                color: Colors.black,
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  isToday ? "Today" : day.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              RingProgress(
                progress: progress,
                done: widget.done,
                size: 28,
                strokeWidth: 4,
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
    this.color = Colors.green,
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
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
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