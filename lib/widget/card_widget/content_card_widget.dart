import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todospark/pages/detail/task_detail_page.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime date;
  final String priority;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final int id;
  final bool isDone;
  final VoidCallback onMarkDone; // Add this callback for marking task as done

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.priority,
    required this.onDelete,
    required this.onEdit,
    required this.id,
    required this.isDone,
    required this.onMarkDone, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    print("isDone status: $isDone"); // Debug print to check the value of isDone

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(
              id: id,
              title: title,
              description: description,
              date: date,
              priority: priority,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Card(
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(description),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date: ${DateFormat('yyyy-MM-dd').format(date)}'),
                      Text(
                        priority,
                        style: TextStyle(
                          color: priority == 'High'
                              ? Colors.red
                              : priority == 'Medium'
                                  ? Colors.orange
                                  : Colors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: onEdit,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: onDelete,
                        ),
                      ],
                    ),
                  ),
                  // Add a checkbox or a button to toggle task done status
                   IconButton(
                    icon: Icon(
                      isDone ? Icons.check_circle : Icons.check_circle_outline,
                      color: isDone ? Colors.green : Colors.grey,
                    ),
                    onPressed:
                        onMarkDone, 
                  ),
                ],
              ),
            ),
          ),
          if (isDone) 
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  'DONE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
