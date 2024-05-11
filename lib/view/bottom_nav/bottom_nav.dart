import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/controller/provider/bottom_nav_provider.dart';
import 'package:weather_app/view/weather_screen/home_page.dart';
import 'package:weather_app/model/bottom_nav_item.dart';
import 'package:weather_app/view/alarm_screen/alarm_screen.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define your screens
    final List<Widget> screens = [
      const HomePaage(),
      const AlarmHomeScreen(),
    ];

    return Scaffold(
      body:
          screens[Provider.of<BottomNavBarProvider>(context).currentItem.index],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 87, 2, 59),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavItem(context, BottomNavItem.weather, 'Weather'),
              buildNavItem(context, BottomNavItem.alarm, 'Alarm'),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavItem(BuildContext context, BottomNavItem item, String label) {
    BottomNavItem currentItem =
        Provider.of<BottomNavBarProvider>(context).currentItem;

    return GestureDetector(
      onTap: () {
        Provider.of<BottomNavBarProvider>(context, listen: false)
            .setCurrentItem(item);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: currentItem == item
              ? const Color.fromARGB(255, 158, 99, 99)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              getIcon(item),
              color: currentItem == item ? Colors.black : Colors.white,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: currentItem == item ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData getIcon(BottomNavItem item) {
    switch (item) {
      case BottomNavItem.weather:
        return Icons.cloud;
      case BottomNavItem.alarm:
        return Icons.alarm_rounded;
    }
  }
}
