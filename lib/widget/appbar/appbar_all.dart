import 'package:flutter/material.dart';

class AppbarAll extends StatelessWidget implements PreferredSizeWidget {
  final String imageUrl;
  final double height;

  const AppbarAll({
    super.key,
    this.imageUrl = 'assets/logo_appbar.png',
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: height,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 125,
            width: 125,
            child: Image.asset(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
