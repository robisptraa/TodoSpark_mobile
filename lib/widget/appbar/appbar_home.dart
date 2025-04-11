import 'package:flutter/material.dart';

class AppbarHome extends StatelessWidget implements PreferredSizeWidget {
  final String imageUrl;
  final double height;

  const AppbarHome({
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
          
        
          const Text(
            "Home",
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

