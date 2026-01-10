import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task_model.dart';

class TaskController extends GetxController {
  final supabase = Supabase.instance.client;
  var tasks = <TaskModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  Future<void> fetchTasks() async {
    try {
      isLoading(true);
      final userId = supabase.auth.currentUser!.id;
      final data = await supabase
          .from('tasks')
          .select()
          .eq('user_id', userId)
          .order('created_at');

      tasks.value = (data as List).map((e) => TaskModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  // --- ADD THIS METHOD BELOW ---
  Future<void> updateTask(String id, String newTitle) async {
    try {
      await supabase
          .from('tasks')
          .update({'title': newTitle})
          .eq('id', id);
      
      // Update the local list so the UI refreshes immediately
      int index = tasks.indexWhere((t) => t.id == id);
      if (index != -1) {
        tasks[index] = TaskModel(
          id: id, 
          title: newTitle, 
          isCompleted: tasks[index].isCompleted
        );
        tasks.refresh(); // Crucial for GetX to see the change
      }
    } catch (e) {
      Get.snackbar('Update Failed', e.toString());
    }
  }
  // -----------------------------

  Future<void> addTask(String title) async {
    await supabase.from('tasks').insert({
      'title': title,
      'user_id': supabase.auth.currentUser!.id,
    });
    fetchTasks();
  }

  Future<void> deleteTask(String id) async {
    await supabase.from('tasks').delete().eq('id', id);
    fetchTasks();
  }
}