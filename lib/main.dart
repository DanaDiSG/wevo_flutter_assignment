import 'package:flutter/material.dart';
import 'data.dart';
import 'item_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Color _color = Colors.white;
  TextEditingController searchBarController = TextEditingController();
  final List<Data> itemList = [
    Data(title: 'Blue', description: 'This is blue', backgroundColor: Colors.blue),
    Data(title: 'Purple', description: 'This is purple', backgroundColor: Colors.purple),
    Data(title: 'Pink', description: 'This is pink', backgroundColor: Colors.pinkAccent),
    Data(title: 'Pink', description: 'This is pink', backgroundColor: Colors.pinkAccent),
    Data(title: 'Pink', description: 'This is pink', backgroundColor: Colors.pinkAccent),
    Data(title: 'Pink', description: 'This is pink', backgroundColor: Colors.pinkAccent),
    Data(title: 'Pink', description: 'This is pink', backgroundColor: Colors.pinkAccent),
    Data(title: 'Pink', description: 'This is pink', backgroundColor: Colors.pinkAccent),
  ];
  List<ItemCard> inputCards = List.empty();
  List<bool> visibilityIndexes = [];
  int lastColorWidgetPressed = -1;

  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    inputCards = buildList(visibilityIndexes);
    const appTitle = 'Wevo Search';
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
                        hintText: 'the search bar',
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
                        if (itemList[i].title.compareTo(searchBarController.text) != 0) {
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
        if (lastColorWidgetPressed == itemList.indexOf(e)
            && _color.value == e.backgroundColor.value) {
          setState(() {
            _color = Colors.white;
          });
        } else {
          setState(() {
            _color = e.backgroundColor;
            lastColorWidgetPressed = itemList.indexOf(e);
          });
        }
      },
    visible: visibilityList.isEmpty ? true : visibilityList[itemList.indexOf(e)],
  )).toList();
  }
}