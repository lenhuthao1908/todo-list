import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = []; // Danh sách công việc chính
  final TextEditingController controller = TextEditingController(); // Controller cho TextField

  // Phương thức thêm công việc mới vào danh sách
  void addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  // Phương thức để thay đổi trạng thái công việc
  void toggleTask(int index) {
    setState(() {
      tasks[index].toggleCompleted();
    });
  }

  // Xóa công việc chính
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Mở màn hình chi tiết công việc
  void viewTaskDetail(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TaskDetailScreen(task: tasks[index], index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Task',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  addTask(value);
                  controller.clear();
                }
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTask(index),
                  ),
                  onTap: () => viewTaskDetail(index), // Xem chi tiết khi bấm vào công việc
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
