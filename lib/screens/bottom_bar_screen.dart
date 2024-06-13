import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:task_app/screens/home_screen.dart';
import 'package:task_app/screens/map_screen.dart';
import 'package:task_app/utils/app_colors.dart';


class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _slideAnimation;
  late AnimationController _controller;
  final screens = [
    const MapScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
    const HomeScreen(),
  ];

  int selectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start below the line
      end: const Offset(0, 0), // End at the original position
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: screens[selectedIndex]),
          Positioned.fill(
            bottom: 20,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  width: size.width * 0.8,
                  height: 60,
                  decoration: BoxDecoration(
                      color: const Color(0xff1b1b1c),
                      borderRadius: BorderRadius.circular(50)),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      bottomBarIcon(IconlyBold.search, 0),
                      bottomBarIcon(IconlyBold.message, 1),
                      bottomBarIcon(IconlyBold.home, 2),
                      bottomBarIcon(IconlyBold.heart, 3),
                      bottomBarIcon(IconlyBold.user2, 4),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomBarIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color:
                selectedIndex == index ? AppColors.primaryColor : Colors.black),
        padding: const EdgeInsets.all(10),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
