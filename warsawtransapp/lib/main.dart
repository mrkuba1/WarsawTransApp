import 'package:flutter/material.dart';
import 'package:warsawtransapp/pages/home.dart';
import 'package:warsawtransapp/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tablica odjazdów',
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: AppColors.primary),
      home: const Home(),
    );
  }
}
