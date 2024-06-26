import 'package:flutter/material.dart';
import 'package:venom_shopping_app/models/grocery_item.dart';
import 'package:venom_shopping_app/widgets/add_new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  
  void _addItem() async{
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
        ),
    );

    if(newItem == null){
      return;
    }

    setState(() {
      _groceryItems.add(newItem);
    });
  }
  void _removedItem(GroceryItem item) {

    setState(() {
      _groceryItems.remove(item);
    });
  }
  @override
  Widget build(BuildContext context) {

    Widget content = const Center(
      child: Text('No items added yet.'),
    );
   if(_groceryItems.isNotEmpty) {
      content =  ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removedItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(_groceryItems[index].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(
              _groceryItems[index].quantity.toString(),
            ),
          ),
        ),
      );
   }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Venom Store'),
        actions: [
          IconButton(onPressed: _addItem, 
          icon: const Icon(Icons.add))
        ],
      ),
      body: content
    );
  }
}