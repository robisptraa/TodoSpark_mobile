import 'package:flutter/material.dart';
import 'package:todospark/widget/appbar/appbar_note.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppbarNote(),
      body: Center(
        child: Text(
          "Note Page",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}