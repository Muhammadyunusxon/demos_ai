import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedGlassBox extends StatelessWidget {
  const FrostedGlassBox(
      {Key? key,
      this.width,
      this.height,
      required this.child,
      required this.color,
      this.sigmaXY,
      this.colorList, this.radius})
      : super(key: key);

  final double? width;
  final double? height;
  final Widget child;
  final Color color;
  final double? sigmaXY;
  final double? radius;
  final List<Color>? colorList;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 24),
      child: Container(
        width: width,
        height: height,
        color: Colors.transparent,
        child: Stack(
          children: [
            BackdropFilter(
              filter:
                  ImageFilter.blur(sigmaX: sigmaXY ?? 4, sigmaY: sigmaXY ?? 4),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius ?? 24),
                // border: Border.all(color: color.withOpacity(0.13)),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: colorList ??
                        [
                          color.withOpacity(0.18),
                          color.withOpacity(0.19),
                        ]),
              ),
            ),
            Center(child: child),
          ],
        ),
      ),
    );
  }
}
