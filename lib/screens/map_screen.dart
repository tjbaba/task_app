import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:task_app/utils/app_colors.dart';

import '../widgets/custom_popup_menue.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  final LatLng _center = const LatLng(51.5, -0.09);
  late AnimationController _controller;
  late AnimationController _controllerMarker;
  late Animation<double> _animation;
  late Animation<double> _sizeAnimation;
  late Animation<double> _animationMarker;

  bool showPrice = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controllerMarker = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 50.0, end: 100.0).animate(_controller)
      ..addListener(() {
        setState(() {
          // Rebuild the widget when the animation value changes
        });
      });

    _sizeAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _animationMarker =
        Tween<double>(begin: 50.0, end: 100.0).animate(_controllerMarker)
          ..addListener(() {
            setState(() {
              // Rebuild the widget when the animation value changes
            });
          });

    _controller.forward();
    _controllerMarker.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 13.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  customMarker(_center, "10,3 mn P"),
                  customMarker(const LatLng(51.487, -0.077), "11 mn P"),
                  customMarker(const LatLng(51.511, -0.085), "7,8 mn P"),
                  customMarker(const LatLng(51.517, -0.070), "8,5 mn P"),
                  customMarker(const LatLng(51.495, -0.110), "6,96 mn P"),
                ],
              ),
            ],
          ),
          Positioned.fill(
              top: 50,
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildAnimatedWidget(
                          Container(
                            width: size.width * 0.6,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: const Row(
                              children: [
                                Icon(IconlyBroken.search),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Saint Petersburg")
                              ],
                            ),
                          ),
                          1),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildAnimatedWidget(
                          Container(
                            width: 45,
                            height: 45,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              IconlyBroken.filter,
                              size: 18,
                            ),
                          ),
                          2),
                    ],
                  ))),
          Positioned.fill(
              bottom: 100,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _buildAnimatedWidget(
                              GestureDetector(
                                onTap: () {
                                  showMenu(
                                    context: context,
                                    position: RelativeRect.fromLTRB(
                                        0, size.height - 250, 30, 0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                    ),
                                    items: [
                                      CustomPopupMenuItem(
                                        icon: Icons.compare_arrows_outlined,
                                        text: 'Cosy areas',
                                        onTap: () {},
                                      ),
                                      CustomPopupMenuItem(
                                        icon: IconlyBroken.wallet,
                                        text: 'Price',
                                        onTap: () {
                                          // Action to perform when Settings is tapped
                                        },
                                      ),
                                      CustomPopupMenuItem(
                                        icon: IconlyBroken.bag,
                                        text: 'Infrastructure',
                                        onTap: () {
                                          // Action to perform when Settings is tapped
                                        },
                                      ),
                                      CustomPopupMenuItem(
                                        icon: Icons.layers_outlined,
                                        text: 'Without any layer',
                                        onTap: () {
                                          Navigator.pop(context);
                                          if (_controllerMarker.status ==
                                              AnimationStatus.completed) {
                                            _controllerMarker.reverse();
                                          } else {
                                            _controllerMarker.forward();
                                          }
                                          setState(() {
                                            showPrice = !showPrice;
                                          });
                                        },
                                      ),
                                      // Add more menu items as needed
                                    ],
                                  );
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.4),
                                      shape: BoxShape.circle),
                                  padding: const EdgeInsets.all(10),
                                  child: const Icon(
                                    Icons.map_outlined,
                                    size: 18,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              3),
                          const SizedBox(
                            height: 5,
                          ),
                          _buildAnimatedWidget(
                              Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.4),
                                    shape: BoxShape.circle),
                                padding: const EdgeInsets.all(10),
                                child: const Icon(
                                  Icons.my_location_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              4),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      _buildAnimatedWidget(
                          Container(
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(50)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 18,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "List of variants",
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          ),
                          6),
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget markerChild(String price) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10))),
      alignment: Alignment.center,
      padding:
          EdgeInsets.symmetric(horizontal: showPrice ? 15 : 10, vertical: 10),
      child: showPrice
          ? Text(
              "${price}",
              maxLines: 1,
              style: TextStyle(color: Colors.white),
            )
          : const Icon(
              Icons.location_on,
              color: Colors.white,
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _controllerMarker.dispose();
    super.dispose();
  }

  customMarker(LatLng latLng, String price) {
    return Marker(
      width: _animationMarker.value,
      height: _animationMarker.value >= 50 ? 50 : _animationMarker.value,
      point: latLng,
      child: markerChild(price),
    );
  }

  Widget _buildAnimatedWidget(Widget child, int delay) {
    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _sizeAnimation,
        child: child,
      ),
    );
  }
}
