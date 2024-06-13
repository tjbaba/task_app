import 'package:flutter/material.dart';
import 'package:task_app/utils/app_colors.dart';

class CustomPopupMenuItem extends PopupMenuEntry<void> {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomPopupMenuItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  double get height => 60; // Adjust the height as needed

  @override
  bool represents(void value) => false;

  @override
  _CustomPopupMenuItemState createState() => _CustomPopupMenuItemState();
}

class _CustomPopupMenuItemState extends State<CustomPopupMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(widget.icon, color: AppColors.textColor1,),
            const SizedBox(width: 16),
            Text(widget.text, style: TextStyle( color: AppColors.textColor1),),
          ],
        ),
      ),
    );
  }
}
