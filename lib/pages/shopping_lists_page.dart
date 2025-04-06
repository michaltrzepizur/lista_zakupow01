import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'shopping_list_editor.dart';

class ShoppingListsPage extends StatefulWidget {
  final List<String> shoppingLists;
  final Function(List<String>) onUpdate;

  const ShoppingListsPage({
    super.key,
    required this.shoppingLists,
    required this.onUpdate,
  });

  @override
  State<ShoppingListsPage> createState() => _ShoppingListsPageState();
}

class _ShoppingListsPageState extends State<ShoppingListsPage> {
  List<String> localLists = [];

  @override
  void initState() {
    super.initState();
    localLists = List<String>.from(widget.shoppingLists);
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('shoppingLists', localLists);
  }

  void _deleteList(String listName) {
    setState(() {
      localLists.remove(listName);
    });
    _saveToPrefs();
    widget.onUpdate(localLists);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Lista "$listName" została usunięta.')),
    );
  }

  void _archiveList(String listName) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Funkcja archiwum nie jest jeszcze dostępna')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Twoje listy zakupów")),
      body: localLists.isEmpty
          ? const Center(child: Text("Brak list do wyświetlenia"))
          : ListView.builder(
              itemCount: localLists.length,
              itemBuilder: (context, index) {
                final listName = localLists[index];
                return Dismissible(
                  key: Key(listName),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.archive, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Archiwum',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.delete_forever, color: Colors.white),
                        SizedBox(width: 8),
                        Text('Usuń',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      _archiveList(listName);
                    } else if (direction == DismissDirection.endToStart) {
                      _deleteList(listName);
                    }
                    return false;
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(
                        listName,
                        style: GoogleFonts.lora(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShoppingListEditor(listName: listName),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
