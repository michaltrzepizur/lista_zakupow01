import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShoppingListsPage extends StatelessWidget {
  final List<String> shoppingLists;

  const ShoppingListsPage({super.key, required this.shoppingLists});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Twoje listy zakupów")),
      body: ListView.builder(
        itemCount: shoppingLists.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                shoppingLists[index],
                style: GoogleFonts.lora(fontSize: 18),
              ),
            ),
          );
        },
      ),
    );
  }
}
