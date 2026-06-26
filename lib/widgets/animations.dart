import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Continuous, gentle floating motion (a slow sine bob) applied to [child].
///
/// Lightweight: one [AnimationController] per instance, translating with a
/// [Transform] only — so it never affects layout. Vary [duration]/[amplitude]/
/// [phase] across instances for independent, offset motion.
class FloatingMotion extends StatefulWidget {
  const FloatingMotion({
    super.key,
    required this.child,
    this.amplitude = 6,
    this.dx = 0,
    this.duration = const Duration(seconds: 3),
    this.phase = 0,
  });

  final Widget child;

  /// Vertical travel in logical pixels (peak offset from rest).
  final double amplitude;

  /// Horizontal travel in logical pixels (0 = pure vertical bob).
  final double dx;

  final Duration duration;

  /// Starting phase (0..1) so instances move out of sync.
  final double phase;

  @override
  State<FloatingMotion> createState() => _FloatingMotionState();
}

class _FloatingMotionState extends State<FloatingMotion>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
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
        final t = (_controller.value + widget.phase) * 2 * math.pi;
        final dy = math.sin(t) * widget.amplitude;
        final dx = widget.dx == 0 ? 0.0 : math.cos(t) * widget.dx;
        return Transform.translate(offset: Offset(dx, dy), child: child);
      },
      child: widget.child,
    );
  }
}

/// A one-shot entrance: fade in (and optionally slide) when first mounted.
///
/// Settles to full opacity at the child's natural position, so it never changes
/// the final UI — only its appearance on open.
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 24),
    this.curve = Curves.easeOut,
  });

  final Widget child;
  final Duration duration;
  final Duration delay;

  /// Starting offset the child slides in from. Use [Offset.zero] for a pure fade.
  final Offset offset;
  final Curve curve;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
    if (widget.delay == Duration.zero) {
      _controller.forward();
    } else {
      Future.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final t = _animation.value;
        return Opacity(
          opacity: t,
          child: Transform.translate(
            offset: Offset(
              widget.offset.dx * (1 - t),
              widget.offset.dy * (1 - t),
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
