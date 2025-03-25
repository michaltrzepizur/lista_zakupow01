import 'package:flutter/material.dart';
import 'package:lista_zakupow01/pages/home_page.dart';

void main() {
  runApp(const MyApp()); // Uruchamiamy aplikację
}

// Klasa MyApp to główny widget aplikacji
class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lista Zakupów',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // Dodajemy const tutaj
    );
  }
}
