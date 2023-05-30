import 'package:flutter/material.dart';
import 'item.dart';
import 'item_card.dart';

void main() => runApp(const WevoSearchBar());

class WevoSearchBar extends StatefulWidget {
  const WevoSearchBar({super.key});

  @override
  State<WevoSearchBar> createState() => _WevoSearchBarState();
}

class _WevoSearchBarState extends State<WevoSearchBar> {

  final List<Item> itemList = [
    Item(title: 'Yes Man', description: 'Best movie ever', backgroundColor: Colors.blue),
    Item(title: 'Joker', description: 'LOL', backgroundColor: Colors.purple),
    Item(title: 'Guardians of the Galaxy', description: 'Haven\'t seen it yet', backgroundColor: Colors.pinkAccent),
    Item(title: 'Harry Potter', description: 'Wizards and magic', backgroundColor: Colors.grey),
    Item(title: 'Lord of the Rings', description: 'Classic', backgroundColor: Colors.pinkAccent),
    Item(title: 'Lord of the Rings 2', description: 'Classic', backgroundColor: Colors.pinkAccent),
    Item(title: 'Lord of the Rings 3', description: 'Classic', backgroundColor: Colors.pinkAccent),
    Item(title: 'Lord of the Rings 4', description: 'Classic', backgroundColor: Colors.pinkAccent),
  ];

  Color _color = Colors.white;
  TextEditingController searchBarController = TextEditingController();
  List<ItemCard> inputCards = List.empty();
  List<bool> visibilityIndexes = [];
  int lastCardPressed = -1;

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inputCards = buildList(visibilityIndexes);
    const appTitle = 'Wevo Energy Search';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        backgroundColor: _color,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextField(
                      controller: searchBarController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Type here to search',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      initVisibility();
                      if (searchBarController.text.isEmpty) {
                        setState(() {
                          inputCards = buildList(visibilityIndexes);
                        });
                        return;
                      }
                      for (int i = 0; i < itemList.length; i++) {
                        if (!itemList[i].title.contains(searchBarController.text)) {
                          setState(() {
                            visibilityIndexes[i] = false;
                          });
                        }
                      }
                      setState(() {
                        inputCards = buildList(visibilityIndexes);
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('submit'),
                  ),
                ],
              ),
              const SizedBox(height: 50.0),
              Column(
                children: inputCards,
              )
            ],
          ),
        ),
      ),
    );
  }

  void initVisibility() {
    List<bool> tempList = [];
    for (int i = 0; i < itemList.length; i++) {
      tempList.add(true);
    }
    setState(() {
      visibilityIndexes = tempList;
    });
  }

  List<ItemCard> buildList(List<bool> visibilityList) {
    return itemList.map((e) =>  ItemCard(
      data : e,
      changeColor: () {
        if (lastCardPressed == itemList.indexOf(e)
            && _color.value == e.backgroundColor.value) {
          setState(() {
            _color = Colors.white;
          });
        } else {
          setState(() {
            _color = e.backgroundColor;
            lastCardPressed = itemList.indexOf(e);
          });
        }
      },
    visible: visibilityList.isEmpty ? true : visibilityList[itemList.indexOf(e)],
  )).toList();
  }
}