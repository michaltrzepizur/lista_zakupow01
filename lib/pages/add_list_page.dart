import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddListPage extends StatefulWidget {
  const AddListPage({super.key});

  @override
  AddListPageState createState() => AddListPageState();
}

class AddListPageState extends State<AddListPage> {
  final TextEditingController _nameController = TextEditingController();

  void _saveList() {
    String listName = _nameController.text.trim();
    if (listName.isNotEmpty) {
      Navigator.pop(context, listName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dodaj listę", style: GoogleFonts.lora(fontSize: 22)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(63.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Nazwa listy",
              style:
                  GoogleFonts.lora(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: "Wpisz nazwę listy...",
                hintStyle: GoogleFonts.lora(fontSize: 16, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 196, 232, 212),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              style: GoogleFonts.lora(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 190,
              height: 52,
              child: ElevatedButton(
                onPressed: _saveList,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF84F1B5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Zapisz listę",
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
