import 'package:get/get.dart';
import 'package:todo_listapp/modules/tasks/controller/api_service.dart';

import '../model/task_model.dart';
import '../../auth/controller/auth_controller.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var loading = false.obs;

  final auth = Get.find<AuthController>();

  final baseUrl = "https://todo-getx-app-5b5f2-default-rtdb.firebaseio.com";

  late TaskService service;

  @override
  void onInit() {
    service = TaskService(baseUrl);
    super.onInit();
  }
  
  /// To get all tasks 
  Future fetchTasks() async {
    try {
      loading(true);

      final data = await service.fetchTasks(auth.userId);

      if (data == null) {
        tasks.clear();
        return;
      }

      List<TaskModel> loaded = [];

      data.forEach((key, value) {
        loaded.add(TaskModel.fromJson(key, value));
      });

      tasks.value = loaded;
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      loading(false);
    }
  }
  
  /// to add tasks 
  Future addTask(String title, String hours) async {
    try {
      await service.addTask(
          auth.userId, {"title": title, "hours": hours, "completed": false});

      fetchTasks();
    } catch (e) {
      Get.snackbar("Error", "Failed to add task");
    }
  }
  
  /// to delete task 
  Future deleteTask(String id) async {
    try {
      await service.deleteTask(auth.userId, id);

      tasks.removeWhere((task) => task.id == id);
      fetchTasks();
    } catch (e) {
      Get.snackbar("Error", "Failed to delete task");
    }
  }
  
  /// to update tasks 
  Future toggleTask(TaskModel task) async {
    try {
      await service.updateTask(
          auth.userId, task.id ?? "", {"completed": !task.completed});

      task.completed = !task.completed;
      tasks.refresh();
      fetchTasks();
    } catch (e) {
      Get.snackbar("Error", "Failed to update task");
    }
  }

  Future editTask(TaskModel task, String title, String hours) async {
    try {
      await service.updateTask(
          auth.userId, task.id ?? "", {"title": title, "hours": hours});

      task.title = title;
      task.hours = hours;

      tasks.refresh();
    } catch (e) {
      Get.snackbar("Error", "Failed to edit task");
    }
  }
}
