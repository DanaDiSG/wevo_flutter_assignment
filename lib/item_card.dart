import 'package:flutter/material.dart';
import 'data.dart';

class ItemCard extends StatelessWidget {

  late final Data data;
  late final Function changeColor;
  late bool visible;

  ItemCard({ required this.data, required this.changeColor, required this.visible });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: GestureDetector(
        onTap: () => changeColor(),
        child: Visibility(
            visible: true,
            child: Card(
            margin: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: data.backgroundColor,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    data.description,
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}