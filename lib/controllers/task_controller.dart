import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todo/db/db_helper.dart';
import '../models/task.dart';
import '../services/notification_services.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) {
    return DBHelper.insert(task);
  }

  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
    for (int x = 0; x < taskList.length; x++) {
      log(taskList[x].isCompleted.toString());
    }
  }

  void deleteTask(Task task) async {
    await DBHelper.delete(task);
    getTasks();
  }

  void deleteAllTask() async {
    Get.defaultDialog(
        title: 'ALert',
        content: Text('Are You Sure You want to delete all tasks.'),
        onConfirm: () async => {
              await DBHelper.deleteAll(),
              NotifyHelper().cancelAllNotification(),
              getTasks(),
              Get.back(),
            },
        onCancel: () => Get.back());
  }

  void markAsCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
