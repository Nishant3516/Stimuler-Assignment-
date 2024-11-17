import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stimuler/features/quiz/domain/entities/day.dart'; // Import Day entity
import 'package:stimuler/features/quiz/presentation/bloc/quiz_bloc.dart'; // Import your QuizBloc

class PathItem {
  final String title;
  final bool isActive;

  PathItem({
    required this.title,
    this.isActive = false,
  });
}

class CurvedZigzagPathProgress extends StatelessWidget {
  final double nodeSize;
  final double pathWidth;
  final Color activeDotColor;
  final Color inactiveDotColor;
  final Color pathColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final TextStyle labelStyle;

  const CurvedZigzagPathProgress({
    Key? key,
    this.nodeSize = 40,
    this.pathWidth = 3,
    this.activeDotColor = Colors.green,
    this.inactiveDotColor = const Color(0xFF1a1b4b),
    this.pathColor = const Color(0xFF1a1b4b),
    this.activeTextColor = Colors.white,
    this.inactiveTextColor = const Color(0xFF999999),
    this.labelStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is QuizError) {
            return Center(child: Text('Error loading data'));
          } else if (state is QuizLoaded) {
            final List<Day> days = state.days;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.1),
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 1.5,
                      ),
                      child: CustomPaint(
                        painter: CurvedZigzagPathPainter(
                          items: _convertDaysToPathItems(days),
                          nodeSize: nodeSize,
                          pathWidth: pathWidth,
                          activeDotColor: activeDotColor,
                          inactiveDotColor: inactiveDotColor,
                          pathColor: pathColor,
                          activeTextColor: activeTextColor,
                          inactiveTextColor: inactiveTextColor,
                          labelStyle: labelStyle,
                          onNodeTap: (pathItem) {
                            _showBottomSheet(context, pathItem);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  // Convert Day entities to PathItem
  List<PathItem> _convertDaysToPathItems(List<Day> days) {
    return days.map((day) {
      return PathItem(
        title: day.title,
        isActive: day.isCurrent,
      );
    }).toList();
  }

  void _showBottomSheet(BuildContext context, PathItem pathItem) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                pathItem.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Details of the selected item will be shown here.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CurvedZigzagPathPainter extends CustomPainter {
  final List<PathItem> items;
  final double nodeSize;
  final double pathWidth;
  final Color activeDotColor;
  final Color inactiveDotColor;
  final Color pathColor;
  final Color activeTextColor;
  final Color inactiveTextColor;
  final TextStyle labelStyle;
  final Function(PathItem) onNodeTap;

  CurvedZigzagPathPainter({
    required this.items,
    required this.nodeSize,
    required this.pathWidth,
    required this.activeDotColor,
    required this.inactiveDotColor,
    required this.pathColor,
    required this.activeTextColor,
    required this.inactiveTextColor,
    required this.labelStyle,
    required this.onNodeTap,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = pathColor
      ..strokeWidth = pathWidth
      ..style = PaintingStyle.stroke;

    final dotPaint = Paint()..style = PaintingStyle.fill;
    final innerDotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    final spacing = (size.height / (items.length - 1)) * 1;
    final amplitude = size.width * 0.4;
    final points = <Offset>[];

    for (var i = 0; i < items.length; i++) {
      final y = i * spacing;
      final x = amplitude *
          math.sin(i * math.pi / (items.length - 1) * (i % 2 == 0 ? 1 : -1));
      points.add(Offset(x + size.width / 2, y));
    }

    final path = Path();
    path.moveTo(points[0].dx, points[0].dy);

    for (var i = 0; i < points.length - 1; i++) {
      final current = points[i];
      final next = points[i + 1];
      final controlPoint1 = Offset(
        current.dx,
        current.dy + (next.dy - current.dy) / 2,
      );
      final controlPoint2 = Offset(
        next.dx,
        next.dy - (next.dy - current.dy) / 2,
      );
      path.cubicTo(
        controlPoint1.dx,
        controlPoint1.dy,
        controlPoint2.dx,
        controlPoint2.dy,
        next.dx,
        next.dy,
      );
    }

    canvas.drawPath(path, paint);

    // Add dots above first node and below last node with spacing
    final firstNode = points[0];
    final lastNode = points[points.length - 1];
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
          Offset(firstNode.dx, firstNode.dy - nodeSize / 2 - i * 15),
          4,
          dotPaint..color = inactiveDotColor);
      canvas.drawCircle(
          Offset(lastNode.dx, lastNode.dy + nodeSize / 2 + i * 15),
          4,
          dotPaint..color = inactiveDotColor);
    }

    for (var i = 0; i < points.length; i++) {
      final point = points[i];
      final item = items[i];

      dotPaint.color = item.isActive ? activeDotColor : inactiveDotColor;
      canvas.drawCircle(point, nodeSize / 2, dotPaint);

      final innerNodeSize = nodeSize / 3;
      canvas.drawCircle(point, innerNodeSize / 3, innerDotPaint);

      textPainter.text = TextSpan(
        text: item.title,
        style: item.isActive
            ? labelStyle.copyWith(color: activeTextColor)
            : labelStyle.copyWith(color: inactiveTextColor),
      );
      textPainter.layout();

      // Define the position of the label
      double labelOffsetX = point.dx + nodeSize / 2 + 8;
      double labelOffsetY = point.dy - nodeSize / 2;

      // If the label exceeds the screen width, position it on the left
      if (labelOffsetX + textPainter.width > size.width) {
        labelOffsetX = point.dx - nodeSize / 2 - textPainter.width - 8;
      }

      // Now, for active nodes, draw the label inside a container with rounded corners
      if (item.isActive) {
        // Draw a container with rounded corners for the text
        final containerWidth = textPainter.width + 16;
        final containerHeight = textPainter.height + 16;
        final containerRect = Rect.fromLTWH(
          labelOffsetX - 8,
          labelOffsetY - containerHeight / 4,
          containerWidth,
          containerHeight,
        );
        final containerPaint = Paint()
          ..color = activeDotColor
          ..style = PaintingStyle.fill;
        canvas.drawRRect(
          RRect.fromRectAndRadius(containerRect, Radius.circular(50)),
          containerPaint,
        );

        textPainter.paint(canvas, Offset(labelOffsetX, labelOffsetY));
      } else {
        textPainter.paint(canvas, Offset(labelOffsetX, labelOffsetY));
      }
      final nodeRect = Rect.fromCircle(center: point, radius: nodeSize / 2);
      if (nodeRect.contains(Offset.zero)) {
        GestureDetector(
          onTap: () => onNodeTap(item), // Trigger bottom sheet on tap
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
