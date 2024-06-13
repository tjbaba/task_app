import 'package:flutter/material.dart';

class AnimatedNumberWidget extends StatefulWidget {
  final int number;
  final Duration duration;
  final TextStyle textStyle;

  const AnimatedNumberWidget({
    super.key,
    required this.number,
    this.duration = const Duration(seconds: 3),
    this.textStyle = const TextStyle(fontSize: 50),
  });

  @override
  _AnimatedNumberWidgetState createState() => _AnimatedNumberWidgetState();
}

class _AnimatedNumberWidgetState extends State<AnimatedNumberWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = IntTween(begin: 0, end: widget.number).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _animation.value.toString(),
      style: widget.textStyle,
    );
  }
}
