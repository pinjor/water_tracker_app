import 'package:flutter/material.dart';
import 'package:water_tracker_app/home_page_screen.dart';

class waterTrackerApp extends StatelessWidget {
  const waterTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageScreen(),
    );
  }
}
