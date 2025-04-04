import 'package:hive/hive.dart';

part 'shopping_list.g.dart';

@HiveType(typeId: 0)
class ShoppingList extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  List<String> items;

  ShoppingList({required this.name, required this.items});
}
