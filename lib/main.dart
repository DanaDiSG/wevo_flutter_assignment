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

  final List<Item> inputList = [
    Item(title: 'Yes Man', description: 'Best movie ever', backgroundColor: Colors.blue),
    Item(title: 'Joker', description: 'LOL', backgroundColor: Colors.purple),
    Item(title: 'Guardians of the Galaxy', description: 'Haven\'t seen it yet', backgroundColor: Colors.pinkAccent),
    Item(title: 'Harry Potter', description: 'Wizards and magic', backgroundColor: Colors.grey),
    Item(title: 'Lord of the Rings', description: 'Classic', backgroundColor: Colors.pinkAccent),
    Item(title: 'Lord of the Rings 2', description: 'Classic', backgroundColor: Colors.pinkAccent),
    Item(title: 'Lord of the Rings 3', description: 'Classic', backgroundColor: Colors.pinkAccent),
    Item(title: 'Lord of the Rings 4', description: 'Classic', backgroundColor: Colors.pinkAccent),
  ];

  Color pageBackgroundColor = Colors.white;
  TextEditingController searchBarController = TextEditingController();
  List<ItemCard> searchList = List.empty();
  List<bool> visibilityIndexes = [];
  int lastCardPressed = -1;

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    searchList = getSearchList(visibilityIndexes);
    const appTitle = 'Wevo Energy Search';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        backgroundColor: pageBackgroundColor,
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
                    onPressed: showSearchResults,
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
                children: searchList,
              )
            ],
          ),
        ),
      ),
    );
  }

  void initVisibility() {
    List<bool> tempList = [];
    for (int i = 0; i < inputList.length; i++) {
      tempList.add(true);
    }
    setState(() {
      visibilityIndexes = tempList;
    });
  }

  List<ItemCard> getSearchList(List<bool> visibilityList) {
    return inputList.map((e) =>  ItemCard(
      data : e,
      changeColor: () {
        if (lastCardPressed == inputList.indexOf(e)
            && pageBackgroundColor.value == e.backgroundColor.value) {
          setState(() {
            pageBackgroundColor = Colors.white;
          });
        } else {
          setState(() {
            pageBackgroundColor = e.backgroundColor;
            lastCardPressed = inputList.indexOf(e);
          });
        }
      },
    visible: visibilityList.isEmpty ? true : visibilityList[inputList.indexOf(e)],
  )).toList();
  }

  void showSearchResults() {
    initVisibility();
    if (searchBarController.text.trim().isNotEmpty) {
      for (int i = 0; i < inputList.length; i++) {
        if (!inputList[i].title.toLowerCase()
            .contains(searchBarController.text.trim().toLowerCase())) {
          setState(() {
            visibilityIndexes[i] = false;
          });
        }
      }
    }
    setState(() {
      searchList = getSearchList(visibilityIndexes);
    });
  }
}