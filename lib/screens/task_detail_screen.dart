import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;
  final int index;

  TaskDetailScreen({required this.task, required this.index});

  @override
  _TaskDetailScreenState createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final TextEditingController subTaskController = TextEditingController();

  // Thêm công việc con
  void addSubTask(String title) {
    setState(() {
      widget.task.addSubTask(SubTask(title: title));
    });
  }

  // Xóa công việc con
  void deleteSubTask(int index) {
    setState(() {
      widget.task.removeSubTask(index);
    });
  }

  // Sửa công việc con
  void editSubTask(int index, String newTitle) {
    setState(() {
      widget.task.editSubTask(index, newTitle);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: subTaskController,
              decoration: InputDecoration(
                labelText: 'Enter Sub-Task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  addSubTask(value);
                  subTaskController.clear();
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.task.subTasks.length,
              itemBuilder: (context, index) {
                final subTask = widget.task.subTasks[index];
                return ListTile(
                  title: Text(
                    subTask.title,
                    style: TextStyle(
                      decoration: subTask.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Sửa công việc con
                          showDialog(
                            context: context,
                            builder: (context) {
                              final TextEditingController editController =
                              TextEditingController(text: subTask.title);
                              return AlertDialog(
                                title: Text('Edit Sub-Task'),
                                content: TextField(
                                  controller: editController,
                                  decoration: InputDecoration(
                                    labelText: 'New Title',
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      editSubTask(index, editController.text);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Save'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteSubTask(index),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      subTask.toggleCompleted();
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
