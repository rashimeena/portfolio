import 'package:flutter/material.dart';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  Offset _mousePosition = const Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    final neonBlue = Theme.of(context).colorScheme.primary;

    return MouseRegion(
      onHover: (event) {
        setState(() {
          _mousePosition = event.localPosition;
        });
      },
      child: Stack(
        children: [
          // Base dark background (optional safety)
          Container(color: Theme.of(context).scaffoldBackgroundColor),

          // Glowing circle that follows mouse
          AnimatedPositioned(
            duration: const Duration(milliseconds: 100),
            left: _mousePosition.dx - 200,
            top: _mousePosition.dy - 200,
            child: IgnorePointer(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      neonBlue.withValues(alpha: 0.25),
                      neonBlue.withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}