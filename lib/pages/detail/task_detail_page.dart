import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todospark/services/db_helper.dart';

class TaskDetailPage extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final String priority;

  const TaskDetailPage({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
  });

  Future<void> _markTaskAsDone(BuildContext context) async {
    await DBHelper().update(
      'task',
      {
        'list_point_task': 'done',
      },
      id,
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Task marked as done!')),
    );
  }

  // void _deleteTask(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) => AlertDialog(
  //       title: const Text('Delete Task'),
  //       content: const Text('Are you sure you want to delete this task?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () async {
  //             await DBHelper().delete('task', id);
  //             Navigator.pop(context);
  //             Navigator.pop(context);
  //             ScaffoldMessenger.of(context).showSnackBar(
  //               const SnackBar(content: Text('Task deleted')),
  //             );
  //           },
  //           child: const Text('Delete', style: TextStyle(color: Colors.red)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () => _markTaskAsDone(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.calendar_today),
                title: const Text('Date'),
                subtitle: Text(DateFormat('EEEE, d MMMM yyyy').format(date)),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const Icon(Icons.flag),
                title: const Text('Priority'),
                subtitle: Text(
                  priority,
                  style: TextStyle(
                    color: priority == 'High'
                        ? Colors.red
                        : priority == 'Medium'
                            ? Colors.orange
                            : Colors.green,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
