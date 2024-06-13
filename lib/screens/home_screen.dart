import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:task_app/utils/app_colors.dart';
import 'package:task_app/widgets/slider_button.dart';

import '../widgets/animiated_number_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _sizeAnimation;
  bool show = true;
  int _value = 1034;
  int _value2 = 2212;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _sizeAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildAnimatedWidget(Widget child) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _sizeAnimation,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(0, -0.5),
            end: Alignment.bottomRight,
            colors: [
              AppColors.backgroundColor2,
              AppColors.backgroundColor,
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              top: 0,
              bottom: MediaQuery.of(context).size.height * 0.45,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildAnimatedWidget(
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                Icon(IconlyBold.location, size: 18, color: AppColors.textColor1),
                                const SizedBox(width: 5),
                                Text("Saint Petersburg", style: TextStyle(color: AppColors.textColor1)),
                              ],
                            ),
                          ),
                        ),
                        _buildAnimatedWidget(
                          Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/images/profile.jpg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildAnimatedWidget(
                      Text(
                        "Hi, Marina",
                        style: TextStyle(color: AppColors.textColor1, fontSize: 24),
                      ),
                    ),
                    const Text(
                      "let's select your perfect place",
                      style: TextStyle(fontSize: 34, height: 1),
                    ).animate().scaleY(
                      duration: const Duration(seconds: 2),
                      curve: Curves.easeInQuad,
                    ),
                    const SizedBox(height: 40),
                    AnimatedContainer(
                      width: double.infinity,
                      height: show ? size.width * 0.45 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildAnimatedWidget(
                            Container(
                              height: size.width * 0.45,
                              width: size.width * 0.45,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "BUY",
                                    style: TextStyle(color: Colors.white, fontSize: 16),
                                  ),
                                  Column(
                                    children: [
                                      AnimatedNumberWidget(
                                        duration: const Duration(seconds: 2),
                                        number: _value,
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Text(
                                        "offers",
                                        style: TextStyle(color: Colors.white, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          _buildAnimatedWidget(
                            Container(
                              height: size.width * 0.45,
                              width: size.width * 0.45,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "RENT",
                                    style: TextStyle(color: AppColors.textColor1, fontSize: 16),
                                  ),
                                  Column(
                                    children: [
                                      AnimatedNumberWidget(
                                        number: _value2,
                                        duration: const Duration(seconds: 2),
                                        textStyle: TextStyle(
                                          color: AppColors.textColor1,
                                          fontSize: 35,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "offers",
                                        style: TextStyle(color: AppColors.textColor1, fontSize: 14),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.45,
              minChildSize: 0.45,
              maxChildSize: 0.7,
              builder: (BuildContext context, ScrollController scrollController) {
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: SingleChildScrollView(
                    controller: scrollController,
                    child: Column(
                      children: [
                        _buildAnimatedWidget(
                          Container(
                            width: size                            .width * 0.95,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: const DecorationImage(
                                image: AssetImage("assets/images/home1.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.bottomLeft,
                            padding: EdgeInsets.only(
                              bottom: 10,
                              left: size.width * 0.05 - 10,
                            ),
                            child: SlidingButton(
                              text: "Gladkova St., 25",
                              onTap: () {},
                              width: size.width * 0.95 - 60,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildAnimatedWidget(
                              Container(
                                width: size.width * 0.46,
                                height: 370,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                    image: AssetImage("assets/images/home2.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                alignment: Alignment.bottomLeft,
                                padding: EdgeInsets.only(
                                  bottom: 10,
                                  left: size.width * 0.05 - 10,
                                ),
                                child: SlidingButton(
                                  text: "Gubina St., 11",
                                  onTap: () {},
                                  width: size.width * 0.46 - 60,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                _buildAnimatedWidget(
                                  Container(
                                    width: size.width * 0.46,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage("assets/images/home3.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    alignment: Alignment.bottomLeft,
                                    padding: EdgeInsets.only(
                                      bottom: 10,
                                      left: size.width * 0.05 - 10,
                                    ),
                                    child: SlidingButton(
                                      text: "Trefoleva St., 43",
                                      onTap: () {},
                                      width: size.width * 0.46 - 60,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                _buildAnimatedWidget(
                                  Container(
                                    width: size.width * 0.46,
                                    height: 180,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: const DecorationImage(
                                        image: AssetImage("assets/images/home3.jpg"),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    alignment: Alignment.bottomLeft,
                                    padding: EdgeInsets.only(
                                      bottom: 10,
                                      left: size.width * 0.05 - 10,
                                    ),
                                    child: SlidingButton(
                                      text: "Sedova St., 22",
                                      onTap: () {},
                                      width: size.width * 0.46 - 60,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

