import 'dart:async';
import 'package:flutter/material.dart';
import 'package:afl2/features/Quiz/presentation/widgets/placeholder_gradient.dart';

/// Background beranda: berganti tiap [interval] dengan crossfade + geser tipis.
/// Kosongkan [imageAssets] untuk memakai gradien placeholder.
class HomeBackgroundSlider extends StatefulWidget {
  const HomeBackgroundSlider({
    super.key,
    this.imageAssets = const [],
    this.interval = const Duration(seconds: 2),
  });

  final List<String> imageAssets;
  final Duration interval;

  @override
  State<HomeBackgroundSlider> createState() => _HomeBackgroundSliderState();
}

class _HomeBackgroundSliderState extends State<HomeBackgroundSlider> {
  Timer? _timer;
  int _index = 0;

  int get _count => widget.imageAssets.isEmpty ? 4 : widget.imageAssets.length;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % _count);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _slide(ColorScheme scheme) {
    if (widget.imageAssets.isEmpty) {
      return DecoratedBox(
        decoration: BoxDecoration(gradient: PlaceholderGradient.of(scheme, _index)),
      );
    }
    return Image.asset(widget.imageAssets[_index], fit: BoxFit.cover);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 700),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.06, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          ),
          child: SizedBox.expand(
            key: ValueKey(_index),
            child: _slide(scheme),
          ),
        ),
        Positioned.fill(
          child: ColoredBox(color: scheme.surface.withValues(alpha: 0.78)),
        ),
      ],
    );
  }
}
