import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider/alarm_provider/alarm_provider.dart';

class AlarmHomeShortcutButton extends StatelessWidget {
  const AlarmHomeShortcutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmProvider>(
      builder: (context, alarmProvider, child) {
        return Row(
          children: [
            GestureDetector(
              onLongPress: () {
                alarmProvider.showMenu = true;
              },
              child: FloatingActionButton(
                onPressed: () => alarmProvider.onPressButton(0, () {}),
                backgroundColor: const Color.fromARGB(255, 154, 137, 136),
                heroTag: null,
                child: const Text("RING NOW", textAlign: TextAlign.center),
              ),
            ),
            if (alarmProvider.showMenu)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () => alarmProvider.onPressButton(24, () {}),
                    child: const Text("+24h"),
                  ),
                  TextButton(
                    onPressed: () => alarmProvider.onPressButton(36, () {}),
                    child: const Text("+36h"),
                  ),
                  TextButton(
                    onPressed: () => alarmProvider.onPressButton(48, () {}),
                    child: const Text("+48h"),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
