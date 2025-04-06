import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_zakupow01/pages/add_list_page.dart';
import 'package:lista_zakupow01/pages/shopping_lists_page.dart';
import 'package:lista_zakupow01/pages/shopping_list_editor.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> shoppingLists = [];

  @override
  void initState() {
    super.initState();
    _loadShoppingLists(); // <- Wczytaj listy przy starcie
  }

  Future<void> _loadShoppingLists() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLists = prefs.getStringList('shoppingLists');
    if (savedLists != null) {
      setState(() {
        shoppingLists = savedLists;
      });
    }
  }

  Future<void> _saveShoppingLists() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('shoppingLists', shoppingLists);
  }

  Future<void> _navigateToAddListPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddListPage()),
    );

    if (result != null && result is String && mounted) {
      setState(() {
        shoppingLists.add(result);
      });

      await _saveShoppingLists(); // <- Zapisz listy po dodaniu

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShoppingListEditor(listName: result),
        ),
      );
    }
  }

  void _navigateToShoppingListsPage() {
    print("🚀 Przejście do list zakupów");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShoppingListsPage(
          shoppingLists: shoppingLists,
          onUpdate: (updatedLists) async {
            setState(() {
              shoppingLists = updatedLists;
            });
            await _saveShoppingLists(); // <- Zapisz po aktualizacji
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 50),
          onPressed: () {},
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 63.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Witaj!',
              style: GoogleFonts.lora(fontSize: 25),
            ),
            const SizedBox(height: 80),
            Text(
              'Zaplanuj swoją listę zakupów',
              style: GoogleFonts.lora(fontSize: 35),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 80),
            _buildButton("Stwórz listę", _navigateToAddListPage),
            const SizedBox(height: 20),
            _buildButton("Przeglądaj listy", _navigateToShoppingListsPage),
            const SizedBox(height: 20),
            _buildButton("Przeglądaj archiwum", () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Archiwum jeszcze nie działa")),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 286,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF84F1B5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
