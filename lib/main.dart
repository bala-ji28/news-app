import 'package:app/model/news_saved_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/home_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(SavedNewsAdapter());
  await Hive.openBox<SavedNews>('newsdb');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(backgroundColor: Colors.grey[100]),
        ),
      ),
      home: const HomePage(),
    );
  }
}
