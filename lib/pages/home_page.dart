import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lista_zakupow01/pages/add_list_page.dart';
import 'package:lista_zakupow01/pages/shopping_lists_page.dart';

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({super.key, required this.userName});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<String> shoppingLists = [];

  Future<void> _navigateToAddListPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddListPage()),
    );

    if (result != null && result is String) {
      setState(() {
        shoppingLists.add(result);
      });
      print("✅ Lista dodana: $shoppingLists");
    }
  }

  void _navigateToShoppingListsPage() {
    print("🚀 Przejście do list zakupów");
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShoppingListsPage(shoppingLists: shoppingLists),
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
              'Witaj ${widget.userName}',
              style: GoogleFonts.lora(fontSize: 25),
            ),
            const SizedBox(height: 80),
            Text(
              'Zaplanuj swoją listę zakupów',
              style: GoogleFonts.lora(fontSize: 35),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 49),
            _buildButton("Stwórz listę", _navigateToAddListPage),
            const SizedBox(height: 30),
            _buildButton("Przeglądaj listy", _navigateToShoppingListsPage),
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
        onPressed: () {
          print("🎯 Kliknięto przycisk: $text");
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF84F1B5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
              fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        ),
      ),
    );
  }
}
