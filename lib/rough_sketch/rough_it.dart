import 'package:flutter/material.dart';
import 'package:me_pass_drive_test/rough_sketch/configs.dart';

class RoadIntersectionPainter extends CustomPainter {
  final int currentLight;
  final double animationValue;

  RoadIntersectionPainter(this.currentLight, this.animationValue);
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    // Calculate the width of the road
    double roadWidth = size.width * roadWidthPercent;

    //Calculate height of divider (vertical)
    double verticalDividerHeight = (size.height - roadWidth) / 2;

    //Calculate height of divider (horizontal)
    double horizontalDividerHeight = (size.width - roadWidth) / 2;

    // Draw vertical road
    canvas.drawRect(
      Rect.fromLTWH(size.width / 2 - roadWidth / 2, 0, roadWidth, size.height),
      paint,
    );

    // Draw horizontal road
    canvas.drawRect(
      Rect.fromLTWH(0, size.height / 2 - roadWidth / 2, size.width, roadWidth),
      paint,
    );

    // Optionally, add road markings
    final roadDividerPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = dividerWidth
      ..strokeCap = StrokeCap.round;

    final trafficSignHolder = Paint()
      ..color = Colors.blueGrey
      ..strokeWidth = dividerWidth
      ..strokeCap = StrokeCap.round;

    //Draw mid divider for vertical top
    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, verticalDividerHeight - 3), roadDividerPaint);

    //Start dashed vertical
    //dashed Mark topRight
    double xStart = (size.width / 2) + ((roadWidth / 2) * 0.5);
    drawDashedMarkings(
        canvas, Offset(xStart, 0), Offset(xStart, verticalDividerHeight),
        isVertical: true);

    //dashed Mark topLeft
    for (int i = 1; i < 3; i++) {
      double xStart = (size.width / 2) - ((roadWidth / 2) * (i / 3));
      drawDashedMarkings(
          canvas, Offset(xStart, 0), Offset(xStart, verticalDividerHeight),
          isVertical: true);
    }

    //dashed Mark bottomRight
    for (int i = 1; i < 3; i++) {
      double xStart = (size.width / 2) + ((roadWidth / 2) * (i / 3));
      drawDashedMarkings(
          canvas,
          Offset(xStart, size.height - verticalDividerHeight - 5),
          Offset(xStart, size.height),
          isVertical: true);
    }

    //dashed Mark bottomLeft
    xStart = (size.width / 2) - ((roadWidth / 2) * 0.5);
    drawDashedMarkings(
        canvas,
        Offset(xStart, size.height - verticalDividerHeight - 5),
        Offset(xStart, size.height),
        isVertical: true);
    //end dashed vertical

    //Start dashed horizontal
    //dashed Mark top Left
    double yStart = (size.height / 2) - ((roadWidth / 2) * 0.5);
    drawDashedMarkings(
        canvas, Offset(0, yStart), Offset(horizontalDividerHeight, yStart),
        isVertical: false);

    //dashed Mark bottomLeft
    for (int i = 1; i < 3; i++) {
      double yStart = (size.height / 2) + ((roadWidth / 2) * (i / 3));
      drawDashedMarkings(
          canvas, Offset(0, yStart), Offset(horizontalDividerHeight, yStart),
          isVertical: false);
    }

    //dashed Mark topRight
    for (int i = 1; i < 3; i++) {
      double yStart = (size.height / 2) - ((roadWidth / 2) * (i / 3));
      drawDashedMarkings(
          canvas,
          Offset(size.width - horizontalDividerHeight, yStart),
          Offset(size.width, yStart),
          isVertical: false);
    }

    //dashed Mark bottomRight
    yStart = (size.height / 2) + ((roadWidth / 2) * 0.5);
    drawDashedMarkings(
        canvas,
        Offset(size.width - horizontalDividerHeight, yStart),
        Offset(size.width, yStart),
        isVertical: false);
    //end dashed horizontal

    //Draw mid divider for vertical bottom
    canvas.drawLine(
        Offset(size.width / 2, size.height),
        Offset(size.width / 2, size.height - verticalDividerHeight),
        roadDividerPaint);

    //Draw mid divider for horizontal left
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(horizontalDividerHeight, size.height / 2), roadDividerPaint);

    //Draw mid divider for horizontal right
    canvas.drawLine(
        Offset(size.width, size.height / 2),
        Offset(size.width - horizontalDividerHeight, size.height / 2),
        roadDividerPaint);
// Draw traffic lights at the corners
    drawTrafficLight(
        canvas,
        size,
        Offset(size.width / 2 - dividerWidth / 2,
            verticalDividerHeight / 3)); // Top-left corner

    //draw line holding top right traffic light
    canvas.drawLine(
        Offset(size.width, verticalDividerHeight / 2),
        Offset(size.width / 2 + (size.width - roadWidth) / 2,
            verticalDividerHeight / 2 + 3),
        trafficSignHolder);

    drawTrafficLight(
        canvas,
        size,
        Offset(
            size.width -
                trafficLightBoxWidth -
                (size.width * restOfRoadWidthPercent) / 2,
            verticalDividerHeight / 3)); // Top-right corner

    drawTrafficLight(
        canvas, size, Offset(0, size.height - 60)); // Bottom-left corner
    drawTrafficLight(canvas, size,
        Offset(size.width - 20, size.height - 60)); // Bottom-right corner

    drawZebraCrossing(
        canvas,
        Rect.fromLTWH(horizontalDividerHeight, verticalDividerHeight, roadWidth,
            roadWidth));
  }

  void drawTrafficLight(Canvas canvas, Size size, Offset position) {
    final trafficLightPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Draw the traffic light box
    canvas.drawRect(
      Rect.fromLTWH(position.dx, position.dy, trafficLightBoxWidth,
          trafficLightBoxHeight),
      trafficLightPaint,
    );

    // Draw the lights
    drawLight(canvas, position + Offset(10, 10), currentLight, animationValue);
  }

  void drawLight(
      Canvas canvas, Offset position, int currentLight, double animationValue) {
    // Draw the lights
    final colors = [Colors.red, Colors.yellow, Colors.green];
    for (int i = 0; i < 3; i++) {
      final lightPaint = Paint()
        ..color = currentLight == i
            ? colors[i].withOpacity(animationValue)
            : colors[i].withOpacity(0.2)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(
          Offset(position.dx + 10, position.dy + 20 * (i + 1)), 10, lightPaint);
    }
  }

  void drawDashedMarkings(Canvas canvas, Offset startCord, Offset endCord,
      {required bool isVertical}) {
    // Optionally, add road markings
    final linePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2;

    if (isVertical) {
      // Draw dashed line for vertical road
      double dashHeight = 10;
      double dashSpace = 10;
      double startY = startCord.dy;
      while (startY < endCord.dy) {
        canvas.drawLine(
          Offset(startCord.dx, startY),
          Offset(startCord.dx, startY + dashHeight),
          linePaint,
        );
        startY += dashHeight + dashSpace;
      }
    } else {
      // Draw dashed line for horizontal road
      double dashWidth = 10;
      double dashSpaceHorizontal = 10;
      double startX = startCord.dx;
      while (startX < endCord.dx) {
        canvas.drawLine(
          Offset(startX, endCord.dy),
          Offset(startX + dashWidth, endCord.dy),
          linePaint,
        );
        startX += dashWidth + dashSpaceHorizontal;
      }
    }
  }

  void drawZebraCrossing(Canvas canvas, Rect rect) {
    final trafficLightPaint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..blendMode = BlendMode.darken;

    // Draw the traffic light box
    canvas.drawRect(rect, trafficLightPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
