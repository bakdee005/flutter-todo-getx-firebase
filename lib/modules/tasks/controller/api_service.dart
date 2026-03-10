import 'dart:convert';
import 'package:http/http.dart' as http;

class TaskService {

  final String baseUrl;

  TaskService(this.baseUrl);

  Future<Map<String, dynamic>?> fetchTasks(String userId) async {
    final url = Uri.parse("$baseUrl/tasks/$userId.json");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to fetch tasks");
    }
  }

  Future<void> addTask(String userId, Map<String, dynamic> task) async {
    final url = Uri.parse("$baseUrl/tasks/$userId.json");

    final response = await http.post(
      url,
      body: json.encode(task),
    );

    if (response.statusCode >= 400) {
      throw Exception("Failed to add task");
    }
  }

  Future<void> deleteTask(String userId, String taskId) async {
    final url = Uri.parse("$baseUrl/tasks/$userId/$taskId.json");

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      throw Exception("Failed to delete task");
    }
  }

  Future<void> updateTask(String userId, String taskId, Map<String, dynamic> data) async {
    final url = Uri.parse("$baseUrl/tasks/$userId/$taskId.json");

    final response = await http.patch(
      url,
      body: json.encode(data),
    );

    if (response.statusCode >= 400) {
      throw Exception("Failed to update task");
    }
  }

}