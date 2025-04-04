import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Klasa MyApp to główny widget aplikacji
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista zakupów',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShoppingListsScreen(),
    );
  }
}

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Twoje listy zakupów')),
      body: Center(child: Text('Tu będzie lista zakupów')),
    );
  }
}
