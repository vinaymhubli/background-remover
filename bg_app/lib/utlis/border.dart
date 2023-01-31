import 'package:flutter/material.dart';

class DashedBorder extends StatefulWidget {
  final Color? color;
  final double strokewidth;
  final double dotswidth;
  final double gap;
  final double radius;
  final Widget child;
  final EdgeInsets? padding;
  const DashedBorder(
      {super.key,
      this.color = Colors.white,
      this.dotswidth = 5.0,
      this.gap = 3.0,
      this.radius = 0,
      this.strokewidth = 1.0,
      required this.child,
      this.padding});

  @override
  State<DashedBorder> createState() => _DashedBorderState();
}

class _DashedBorderState extends State<DashedBorder> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedPaint(
          color: widget.color!,
          dottedLength: widget.dotswidth,
          space: widget.gap,
          strokeWidth: widget.strokewidth,
          radius: widget.radius),
      child: Container(
        padding: widget.padding ?? const EdgeInsets.all(2),
        child: widget.child,
      ),
    );
  }
}

class _DottedPaint extends CustomPainter {
  Color? color;
  double? dottedLength;
  double? space;
  double? strokeWidth;
  double? radius;
  _DottedPaint({
    this.color,
    this.dottedLength,
    this.space,
    this.strokeWidth,
    this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..color = color!
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth!;
    Path path = Path();
    path.addRRect(RRect.fromLTRBR(
        0, 0, size.width, size.height, Radius.circular(radius!)));
    Path draw = buildDashPath(path, dottedLength!, space!);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  Path buildDashPath(Path path, double d, double e) {
    return Path();
  }
}
