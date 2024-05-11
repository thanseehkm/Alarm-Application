import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alarm/alarm.dart';

class AlarmSettingsProvider extends ChangeNotifier {
  bool loading = false;
  late bool creating;
  late DateTime selectedDateTime;
  late bool loopAudio;
  late bool vibrate;
  late double? volume;
  late String assetAudio;
  final AlarmSettings? initialSettings;

  AlarmSettingsProvider({this.initialSettings}) {
    creating = initialSettings == null;

    if (creating) {
      selectedDateTime = DateTime.now().add(const Duration(minutes: 1));
      selectedDateTime = selectedDateTime.copyWith(second: 0, millisecond: 0);
      loopAudio = true;
      vibrate = true;
      volume = null;
      assetAudio = 'assets/marimba.mp3';
    } else {
      selectedDateTime = initialSettings!.dateTime;
      loopAudio = initialSettings!.loopAudio;
      vibrate = initialSettings!.vibrate;
      volume = initialSettings!.volume;
      assetAudio = initialSettings!.assetAudioPath;
    }
  }

  String getDay() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final difference = selectedDateTime.difference(today).inDays;

    switch (difference) {
      case 0:
        return 'Today';
      case 1:
        return 'Tomorrow';
      case 2:
        return 'After tomorrow';
      default:
        return 'In $difference days';
    }
  }

  Future<void> pickTime(BuildContext context) async {
    final res = await showTimePicker(
      initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      context: context,
    );

    if (res != null) {
      final DateTime now = DateTime.now();
      selectedDateTime = now.copyWith(
        hour: res.hour,
        minute: res.minute,
        second: 0,
        millisecond: 0,
        microsecond: 0,
      );
      if (selectedDateTime.isBefore(now)) {
        selectedDateTime = selectedDateTime.add(const Duration(days: 1));
      }
      notifyListeners();
    }
  }

  AlarmSettings buildAlarmSettings() {
    final id = creating
        ? DateTime.now().millisecondsSinceEpoch % 10000
        : initialSettings!.id;

    return AlarmSettings(
      id: id,
      dateTime: selectedDateTime,
      loopAudio: loopAudio,
      vibrate: vibrate,
      volume: volume,
      assetAudioPath: 'assets/ringtone/nokia_original_theme.mp3',
      notificationTitle: 'Alarm example',
      notificationBody: 'Your alarm ($id) is ringing',
    );
  }

  void saveAlarm(BuildContext context) {
    if (loading) return;
    loading = true;
    notifyListeners();

    Alarm.set(alarmSettings: buildAlarmSettings()).then((res) {
      if (res) {
        Navigator.pop(context, true);
      }
      loading = false;
      notifyListeners();
    });
  }

  void deleteAlarm(BuildContext context) {
    Alarm.stop(initialSettings!.id).then((res) {
      if (res) {
        Navigator.pop(context, true);
      }
    });
  }
}
