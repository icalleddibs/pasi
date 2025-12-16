import 'package:flutter/material.dart';

// POSTCARD BORDER DESIGN --------------------------------------------------------------------------------------------

class PostcardContainer extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final double borderRadius;
  final Gradient gradient;

  const PostcardContainer({
    super.key,
    required this.child,
    required this.gradient,
    this.strokeWidth = 24,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _PostcardBorderPainter(
        gradient: gradient,
        strokeWidth: strokeWidth,
        radius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

class _PostcardBorderPainter extends CustomPainter {
  final Gradient gradient;
  final double strokeWidth;
  final double radius;

  _PostcardBorderPainter({
    required this.gradient,
    required this.strokeWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    final paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)));

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_) => false;
}


// RIBBON SHAPE FOR THE BOOKMARKS ---------------------------------------------------------------------------------------

class RibbonClipper extends CustomClipper<Path> {
  @override
Path getClip(Size size) {
  final path = Path();
  double cutWidth = 16; // width of the triangle cutout on each side

  // Start at the top-left corner
  path.moveTo(0, 0);
  // Line to the start of the right cut
  path.lineTo(size.width + cutWidth, 0);
  // Line to the tip of the right triangle (cutting in)
  path.lineTo(size.width, size.height / 2);
  // Line to the end of the right cut
  path.lineTo(size.width + cutWidth, size.height);
  // Line to the bottom-left corner
  path.lineTo(0, size.height);
  // Line to the tip of the left triangle (cutting in)
  path.lineTo(cutWidth, size.height / 2);
  // Close the path
  path.close();

  return path;
}

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}