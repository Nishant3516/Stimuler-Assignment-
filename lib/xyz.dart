// import 'package:flutter/material.dart';
// import 'dart:math' as math;

// class PathItem {
//   final String title;
//   final bool isActive;

//   PathItem({
//     required this.title,
//     this.isActive = false,
//   });
// }

// class CurvedZigzagPathProgress extends StatelessWidget {
//   final List<PathItem> items;
//   final double nodeSize;
//   final double pathWidth;
//   final Color activeDotColor;
//   final Color inactiveDotColor;
//   final Color pathColor;
//   final Color activeTextColor;
//   final Color inactiveTextColor;
//   final TextStyle labelStyle;

//   const CurvedZigzagPathProgress({
//     Key? key,
//     required this.items,
//     this.nodeSize = 40,
//     this.pathWidth = 3,
//     this.activeDotColor = Colors.green,
//     this.inactiveDotColor = const Color(0xFF1a1b4b),
//     this.pathColor = const Color(0xFF1a1b4b),
//     this.activeTextColor = Colors.white,
//     this.inactiveTextColor = const Color(0xFF999999),
//     this.labelStyle = const TextStyle(
//       fontSize: 14,
//       fontWeight: FontWeight.bold,
//     ),
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SingleChildScrollView(
//         padding: EdgeInsets.symmetric(
//             vertical: MediaQuery.of(context).size.height * 0.1),
//         child: Center(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width * 0.8,
//             child: SingleChildScrollView(
//               child: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minHeight: MediaQuery.of(context).size.height * 1.5,
//                 ),
//                 child: CustomPaint(
//                   painter: CurvedZigzagPathPainter(
//                     items: items,
//                     nodeSize: nodeSize,
//                     pathWidth: pathWidth,
//                     activeDotColor: activeDotColor,
//                     inactiveDotColor: inactiveDotColor,
//                     pathColor: pathColor,
//                     activeTextColor: activeTextColor,
//                     inactiveTextColor: inactiveTextColor,
//                     labelStyle: labelStyle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class CurvedZigzagPathPainter extends CustomPainter {
//   final List<PathItem> items;
//   final double nodeSize;
//   final double pathWidth;
//   final Color activeDotColor;
//   final Color inactiveDotColor;
//   final Color pathColor;
//   final Color activeTextColor;
//   final Color inactiveTextColor;
//   final TextStyle labelStyle;

//   CurvedZigzagPathPainter({
//     required this.items,
//     required this.nodeSize,
//     required this.pathWidth,
//     required this.activeDotColor,
//     required this.inactiveDotColor,
//     required this.pathColor,
//     required this.activeTextColor,
//     required this.inactiveTextColor,
//     required this.labelStyle,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = pathColor
//       ..strokeWidth = pathWidth
//       ..style = PaintingStyle.stroke;

//     final dotPaint = Paint()..style = PaintingStyle.fill;
//     final innerDotPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;

//     final textPainter = TextPainter(
//       textDirection: TextDirection.ltr,
//       textAlign: TextAlign.left,
//     );

//     final spacing = (size.height / (items.length - 1)) * 1;
//     final amplitude = size.width * 0.4;
//     final points = <Offset>[];

//     for (var i = 0; i < items.length; i++) {
//       final y = i * spacing;
//       final x = amplitude *
//           math.sin(i * math.pi / (items.length - 1) * (i % 2 == 0 ? 1 : -1));
//       points.add(Offset(x + size.width / 2, y));
//     }

//     final path = Path();
//     path.moveTo(points[0].dx, points[0].dy);

//     for (var i = 0; i < points.length - 1; i++) {
//       final current = points[i];
//       final next = points[i + 1];
//       final controlPoint1 = Offset(
//         current.dx,
//         current.dy + (next.dy - current.dy) / 2,
//       );
//       final controlPoint2 = Offset(
//         next.dx,
//         next.dy - (next.dy - current.dy) / 2,
//       );
//       path.cubicTo(
//         controlPoint1.dx,
//         controlPoint1.dy,
//         controlPoint2.dx,
//         controlPoint2.dy,
//         next.dx,
//         next.dy,
//       );
//     }

//     canvas.drawPath(path, paint);

//     for (var i = 0; i < points.length; i++) {
//       final point = points[i];
//       final item = items[i];

//       dotPaint.color = item.isActive ? activeDotColor : inactiveDotColor;
//       canvas.drawCircle(point, nodeSize / 2, dotPaint);

//       final innerNodeSize = nodeSize / 3;
//       canvas.drawCircle(point, innerNodeSize / 2, innerDotPaint);

//       textPainter.text = TextSpan(
//         text: item.title,
//         style: item.isActive
//             ? labelStyle.copyWith(color: activeTextColor)
//             : labelStyle.copyWith(color: inactiveTextColor),
//       );
//       textPainter.layout();

//       double labelOffsetX = point.dx + nodeSize / 2 + 8;
//       double labelOffsetY = point.dy - nodeSize / 2;

//       if (labelOffsetX + textPainter.width > size.width) {
//         labelOffsetX = point.dx - nodeSize / 2 - textPainter.width - 8;
//       }

//       final labelOffset = Offset(labelOffsetX, labelOffsetY);

//       textPainter.paint(canvas, labelOffset);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
