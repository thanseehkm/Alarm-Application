// alarm_provider.dart
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';

class AlarmProvider extends ChangeNotifier {
  late List<AlarmSettings> _alarms;

  AlarmProvider() {
    _alarms = Alarm.getAlarms();
    _alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
  }

  List<AlarmSettings> get alarms => _alarms;

  Future<void> loadAlarms() async {
    _alarms = Alarm.getAlarms();
    _alarms.sort((a, b) => a.dateTime.isBefore(b.dateTime) ? 0 : 1);
    notifyListeners();
  }

  bool _showMenu = false;

  bool get showMenu => _showMenu;

  set showMenu(bool value) {
    _showMenu = value;
    notifyListeners();
  }

  Future<void> onPressButton(int delayInHours, Function() refreshAlarms) async {
    DateTime dateTime = DateTime.now().add(Duration(hours: delayInHours));
    double? volume;

    if (delayInHours != 0) {
      dateTime = dateTime.copyWith(second: 0, millisecond: 0);
      volume = 0.5;
    }

    showMenu = false;

    final alarmSettings = AlarmSettings(
      id: DateTime.now().millisecondsSinceEpoch % 10000,
      dateTime: dateTime,
      assetAudioPath: 'assets/ringtone/nokia_original_theme.mp3',
      volume: volume,
      notificationTitle: 'Alarm example',
      notificationBody:
          'Shortcut button alarm with delay of $delayInHours hours',
    );

    await Alarm.set(alarmSettings: alarmSettings);

    refreshAlarms();
  }
}
