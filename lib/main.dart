import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/provider.dart';
import 'screens/home_page.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "My Todo",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
