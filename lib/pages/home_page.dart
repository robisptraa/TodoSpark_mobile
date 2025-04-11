import 'package:flutter/material.dart';
import 'package:todospark/widget/appbar/appbar_home.dart';
import 'package:todospark/widget/bottomsheet/create_list.dart';
import 'package:todospark/widget/button/fab_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  void _showCreateTodoSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CreateTodoSheet(
            titleController: titleController,
            descriptionController: descriptionController,
            onSave: () {
              print(
                  "Saved: ${titleController.text} - ${descriptionController.text}");
              Navigator.pop(context);
              titleController.clear();
              descriptionController.clear();
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppbarHome(),
      body: const SizedBox.shrink(),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 80.0),
        child: FabButton(onPressed: _showCreateTodoSheet),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
