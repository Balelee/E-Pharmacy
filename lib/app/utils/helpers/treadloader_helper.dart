import 'package:flutter/material.dart';
import 'package:pharmix/app/themes/app_colors.dart';

class ThreeDotsLoader extends StatefulWidget {
  final int length;
  const ThreeDotsLoader({super.key, this.length = 3}); // valeur par défaut

  @override
  _ThreeDotsLoaderState createState() => _ThreeDotsLoaderState();
}

class _ThreeDotsLoaderState extends State<ThreeDotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Color> colors;

  @override
  void initState() {
    super.initState();
    colors = List.generate(
      widget.length,
      (index) => index.isEven ? AppColors.primary : AppColors.success,
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            double t =
                (_controller.value * widget.length - index).clamp(0.0, 1.0);
            double scale = 0.7 + 0.6 * t;

            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: t,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: colors[index],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
