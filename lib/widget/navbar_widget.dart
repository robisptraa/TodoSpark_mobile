import 'package:flutter/material.dart';

class Navbar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const Navbar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0xff008CFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: IntrinsicWidth(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _navItem(Icons.home, "Home", 0),
            const SizedBox(width: 80),
            _navItem(Icons.note, "Note", 1),
            const SizedBox(width:80),
            _navItem(Icons.person, "Profile", 2),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => widget.onTabChange(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                widget.selectedIndex == index ? Colors.white : Colors.black,
          ),
          Text(
            label,
            style: TextStyle(
              color:
                  widget.selectedIndex == index ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
