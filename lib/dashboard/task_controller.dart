import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task_model.dart';

class TaskController extends GetxController {
  final supabase = Supabase.instance.client;

  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  int get ongoingCount => tasks.where((t) => !t.isCompleted).length;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  // READ: Fetch all tasks for the logged-in user
  Future<void> fetchTasks() async {
    try {
      isLoading(true);
      final userId = supabase.auth.currentUser!.id;

      final data = await supabase
          .from('tasks')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      tasks.value = (data as List).map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar(
        'Error Fetching Tasks',
        e.toString(),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading(false);
    }
  }

  // CREATE: Add a new task with Title and Description
  Future<void> addTask(String title, String description) async {
    try {
      await supabase.from('tasks').insert({
        'title': title,
        'description': description,
        'user_id': supabase.auth.currentUser!.id,
        'is_completed': false,
      });
      await fetchTasks();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not add task. Ensure "description" column exists in Supabase.',
      );
    }
  }

  // UPDATE: Change Title and Description
  Future<void> updateTask(String id, String newTitle, String newDesc) async {
    try {
      await supabase
          .from('tasks')
          .update({'title': newTitle, 'description': newDesc})
          .eq('id', id);

      // Update local state immediately for speed
      int index = tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        tasks[index] = TaskModel(
          id: id,
          title: newTitle,
          description: newDesc,
          isCompleted: tasks[index].isCompleted,
        );
        tasks.refresh();
      }
      Get.snackbar('Success', 'Task updated successfully');
    } catch (e) {
      Get.snackbar('Update Failed', e.toString());
    }
  }

  // UPDATE: Toggle between Ongoing and Completed
  Future<void> toggleTaskStatus(String id, bool currentStatus) async {
    try {
      final newStatus = !currentStatus;
      await supabase
          .from('tasks')
          .update({'is_completed': newStatus})
          .eq('id', id);

      // Update local list to reflect in Profile Stats immediately
      int index = tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        tasks[index] = TaskModel(
          id: id,
          title: tasks[index].title,
          description: tasks[index].description,
          isCompleted: newStatus,
        );
        tasks.refresh();
      }

      Get.snackbar(
        'Status Updated',
        newStatus ? 'Task marked as Completed' : 'Task moved to Ongoing',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white12,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Status Update Failed', e.toString());
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await supabase.from('tasks').delete().eq('id', id);
      tasks.removeWhere((t) => t.id == id);
    } catch (e) {
      Get.snackbar('Delete Failed', e.toString());
    }
  }
}
