import 'package:flutter_notifications/services/local_notification_service.dart';
import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyTask() async {
    // await Workmanager().registerOneOffTask('id1', 'Show Simple Notification');
    await Workmanager().registerPeriodicTask(
      'id1',
      'Show Simple Notification',
      frequency: const Duration(hours: 1),
    );
  }

  // Init Work Manager Service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: false);
    // Register My Task
    registerMyTask();
  }

  void cancelTaskByUniqueName(String uniqueName) {
    Workmanager().cancelByUniqueName(uniqueName);
  }

  void cancelTaskByTag(String tagName) {
    Workmanager().cancelByTag(tagName);
  }

  void cancelAllTasks() {
    Workmanager().cancelAll();
  }
}

@pragma('vm:entry-point')
void actionTask() {
  // Show Notification
  Workmanager().executeTask((task, inputData) {
    LocalNotificationService.showDailyScheduledNotification();
    return Future.value(true);
  });
}
