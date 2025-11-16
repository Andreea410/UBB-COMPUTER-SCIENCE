import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/trip_view_model.dart';
import '../screens/trip_list_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TripViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TripMate',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TripListPage(),
    );
  }
}
