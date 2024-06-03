import 'package:flutter/material.dart';

import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDarkMode = false;

  void toggleTheme(){
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {



    return MaterialApp(
      title: 'Todo',
      debugShowCheckedModeBanner: false,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
        useMaterial3: false,
        // floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //   backgroundColor: Colors.green,
        // ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
        useMaterial3: false,
        floatingActionButtonTheme:
            const FloatingActionButtonThemeData(backgroundColor: Colors.brown),
      ),
      home:  HomeScreen(isDarkMode: isDarkMode,toggleTheme: toggleTheme,),
    );
  }
}
