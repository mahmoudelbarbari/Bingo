import 'package:flutter/material.dart';
import '../painters/circle_progress_painter.dart';

class ProgressButton extends StatefulWidget {
  final double progress;
  final VoidCallback onPressed;
  final double? size; // Optional custom size

  const ProgressButton({
    super.key,
    required this.progress,
    required this.onPressed,
    this.size,
  });

  @override
  State<ProgressButton> createState() => _ProgressButtonState();
}

class _ProgressButtonState extends State<ProgressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant ProgressButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.progress != oldWidget.progress) {
      _controller.reset();

      _animation = Tween<double>(begin: 0.0, end: widget.progress).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );

      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size ?? MediaQuery.of(context).size.width * 0.12;
    final double padding = 10;

    return SizedBox(
      width: size + padding * 2,
      height: size + padding * 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (_, __) {
          return CustomPaint(
            painter: CircleProgressPainter(progress: _animation.value),
            child: Center(
              child: InkWell(
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(size),
                child: Container(
                  width: size,
                  height: size,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC2185B),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: size * 0.5,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
