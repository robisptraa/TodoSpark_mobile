import 'package:flutter/material.dart';

class FabButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FabButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
