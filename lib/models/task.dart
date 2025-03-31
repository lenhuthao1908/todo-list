class SubTask {
  String title; // Tiêu đề công việc con
  bool isCompleted; // Trạng thái công việc con

  // constructor
  SubTask(
      {required this.title, this.isCompleted = false});

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }
}

class Task {
  String title; // Tiêu đề công việc
  bool isCompleted; // Trạng thái công việc
  List<SubTask> subTasks; // Danh sách các công việc con

  Task({required this.title, this.isCompleted = false, List<SubTask>? subTasks})
      : subTasks = subTasks ?? [];

  void toggleCompleted() {
    isCompleted = !isCompleted;
  }

  // Thêm công việc con vào công việc chính
  void addSubTask(SubTask subTask) {
    subTasks.add(subTask);
  }

  // Xóa công việc con theo index
  void removeSubTask(int index) {
    if (index >= 0 && index < subTasks.length) {
      subTasks.removeAt(index);
    }
  }

  // Sửa công việc con
  void editSubTask(int index, String newTitle) {
    if (index >= 0 && index < subTasks.length) {
      subTasks[index].title = newTitle;
    }
  }
}
