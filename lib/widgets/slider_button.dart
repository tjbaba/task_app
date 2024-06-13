import 'package:flutter/material.dart';

class SlidingButton extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final double width;

  const SlidingButton({super.key, required this.text, required this.onTap, required this.width});

  @override
  _SlidingButtonState createState() => _SlidingButtonState();
}

class _SlidingButtonState extends State<SlidingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _hasSlid = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<double>(
      begin: 0.0,
      end:
      widget.width, // Adjust this value to match the width of the container minus the button width
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeIn),
    ));

    _controller.forward().then((value) {
      setState(() {
        _hasSlid = true;
      });
      widget.onTap();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _slideAnimation,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedContainer(
              width: 40 +
                  _slideAnimation.value, // Adjust container width dynamically
              height: 40,
              duration: const Duration(milliseconds: 0), // Immediate effect
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: _hasSlid
                      ? Text(
                          widget.text,
                          style: const TextStyle(fontSize: 18, color: Colors.black),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            Positioned(
              left: _slideAnimation.value,
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: const Icon(Icons.arrow_forward_ios_outlined, size: 12,),
              ),
            ),
          ],
        );
      },
    );
  }
}
