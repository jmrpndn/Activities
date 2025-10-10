import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const RefrigerationACApp());
}

class RefrigerationACApp extends StatelessWidget {
  const RefrigerationACApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refrigeration & AC Services',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

