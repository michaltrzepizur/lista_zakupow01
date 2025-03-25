import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, size: 50),
          onPressed: () {
            // Tu dodamy menu
          },
        ),
        backgroundColor: Colors.transparent, // Opcjonalnie: przezroczyste tło
        elevation: 0, // Usunięcie cienia
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 63.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Witaj Name',
              style: GoogleFonts.irishGrover(fontSize: 25),
            ),
            const SizedBox(height: 20),
            Text(
              'Zaplanuj swoją listę zakupów...',
              style: GoogleFonts.irishGrover(fontSize: 35),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildButton(context, 'Stwórz listę', () {
              // TODO: Dodamy później nawigację do nowej listy
            }),
            const SizedBox(height: 49),
            _buildButton(context, 'Przeglądaj listy', () {
              // TODO: Dodamy później nawigację do list
            }),
            const SizedBox(height: 49),
            _buildButton(context, 'Przeglądaj archiwum', () {
              // TODO: Dodamy później nawigację do archiwum
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return SizedBox(
      width: 286,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF84F1B5), // kolor przycisku
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // zaokrąglenie rogów
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
