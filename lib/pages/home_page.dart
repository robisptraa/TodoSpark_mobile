import 'package:flutter/material.dart';
import 'package:todospark/services/db_helper.dart';
import 'package:todospark/widget/appbar/appbar_home.dart';
import 'package:todospark/widget/bottomsheet/create_list.dart';
import 'package:todospark/widget/bottomsheet/edit_list.dart';
import 'package:todospark/widget/button/fab_button.dart';
import 'package:todospark/widget/card_widget/content_card_widget.dart';

import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DBHelper dbHelper = DBHelper();
  List<Map<String, dynamic>> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final db = await dbHelper.database;
    final data = await db.query('task');
    setState(() {
      tasks = data;
    });
  }

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
              fetchTasks();
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
      appBar: AppbarHome(),
      body: Stack(
        children: [
          tasks.isEmpty
              ? const Center(child: Text('No tasks yet!'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: TaskCard(
                        title: task['title_task'],
                        description: task['description_task'],
                        date: DateFormat('yyyy-MM-dd').parse(task['date']),
                        priority: task['priority'],
                        onDelete: () async {
                          final db = await dbHelper.database;
                          await db.delete('task',
                              where: 'id = ?', whereArgs: [task['id']]);
                          fetchTasks();
                        },
                        onEdit: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) => EditTaskBottomSheet(
                              initialTitle: task['title_task'],
                              initialDescription: task['description_task'],
                              initialDate:
                                  DateFormat('yyyy-MM-dd').parse(task['date']),
                              initialPriority: task['priority'],
                              onSave: (newTitle, newDescription, newDate,
                                  newPriority) async {
                                final db = await dbHelper.database;
                                await db.update(
                                  'task',
                                  {
                                    'title_task': newTitle,
                                    'description_task': newDescription,
                                    'date': DateFormat('yyyy-MM-dd')
                                        .format(newDate),
                                    'priority': newPriority,
                                  },
                                  where: 'id = ?',
                                  whereArgs: [task['id']],
                                );
                                fetchTasks();
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
          Positioned(
            bottom: 100,
            right: 20,
            child: FabButton(
              onPressed: _showCreateTodoSheet,
            ),
          ),
        ],
      ),
    );
  }
}
