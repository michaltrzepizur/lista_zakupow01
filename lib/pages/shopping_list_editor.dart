import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingListEditor extends StatefulWidget {
  final String listName;

  const ShoppingListEditor({super.key, required this.listName});

  @override
  State<ShoppingListEditor> createState() => _ShoppingListEditorState();
}

class _ShoppingListEditorState extends State<ShoppingListEditor> {
  final TextEditingController _itemController = TextEditingController();
  final List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _addItem() {
    final text = _itemController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _items.add({'name': text, 'bought': false});
        _itemController.clear();
        _saveItems();
      });
    }
  }

  void _onItemDoubleTap(int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final item = _items[index];
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(item['bought'] ? Icons.undo : Icons.check),
              title: Text(item['bought']
                  ? 'Oznacz jako NIEkupione'
                  : 'Oznacz jako kupione'),
              onTap: () {
                setState(() {
                  item['bought'] = !item['bought'];
                  _saveItems();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edytuj nazwę'),
              onTap: () {
                Navigator.pop(context);
                _showEditDialog(index);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Usuń'),
              onTap: () {
                setState(() {
                  _items.removeAt(index);
                  _saveItems();
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDialog(int index) {
    final TextEditingController editController =
        TextEditingController(text: _items[index]['name']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edytuj pozycję'),
        content: TextField(
          controller: editController,
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              final newText = editController.text.trim();
              if (newText.isNotEmpty) {
                setState(() {
                  _items[index]['name'] = newText;
                  _saveItems();
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Zapisz'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedItems = jsonEncode(_items);
    await prefs.setString('items_${widget.listName}', encodedItems);
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedItems = prefs.getString('items_${widget.listName}');
    if (encodedItems != null) {
      final decodedItems =
          List<Map<String, dynamic>>.from(jsonDecode(encodedItems));
      setState(() {
        _items.clear();
        _items.addAll(decodedItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.listName),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemController,
                    decoration:
                        const InputDecoration(hintText: 'Dodaj nową pozycję'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return GestureDetector(
                  onDoubleTap: () => _onItemDoubleTap(index),
                  child: ListTile(
                    title: Text(
                      item['name'],
                      style: TextStyle(
                        decoration: item['bought']
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
