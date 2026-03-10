class TaskModel {
  String? id;
  String title;
  String hours;
  bool completed;

  TaskModel({
    this.id,
    required this.title,
    required this.hours,
    this.completed = false,
  });

  factory TaskModel.fromJson(String id, Map data) {
    return TaskModel(
      id: id,
      title: data["title"],
      hours: data["hours"],
      completed: data["completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "hours": hours,
      "completed": completed,
    };
  }
}