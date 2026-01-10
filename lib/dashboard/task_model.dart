// lib/dashboard/task_model.dart
class TaskModel {
  final String id;
  final String title;
  final String description; // Added
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'].toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? '', // Added
      isCompleted: json['is_completed'] ?? false,
    );
  }
}