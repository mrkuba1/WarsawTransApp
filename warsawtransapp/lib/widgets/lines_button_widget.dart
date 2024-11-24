import 'package:flutter/material.dart';

import '../data/lines/models/busline.dart';

class LinesButtonsWidget extends StatefulWidget {
  final List<BusLine> items;
  final Function(List<BusLine>) onLinesSelected;

  const LinesButtonsWidget({
    Key? key,
    required this.items,
    required this.onLinesSelected,
  }) : super(key: key);

  @override
  _LinesButtonsWidgetState createState() => _LinesButtonsWidgetState();

  static of(BuildContext context) {}
}

class _LinesButtonsWidgetState extends State<LinesButtonsWidget> {
  late List<Color> containerColors;
  late List<bool> isToggled;

  @override
  void initState() {
    super.initState();
    containerColors = List.filled(widget.items.length - 1, Colors.blue[100]!);
    isToggled = List.filled(widget.items.length - 1, false);
  }

  List<BusLine> getSelectedLines() {
    List<BusLine> selectedLines = [];
    for (int i = 0; i < isToggled.length; i++) {
      if (isToggled[i]) {
        selectedLines.add(widget.items[i + 1]);
      }
    }
    return selectedLines;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Builder(
        builder: (context) {
          if (widget.items.isEmpty) {
            return Container(
              alignment: Alignment.center,
              child: const Text(
                'Ten przystanek jest pusty',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return GridView.builder(
            itemCount: widget.items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isToggled[index] = !isToggled[index];
                    containerColors[index] = isToggled[index]
                        ? Colors.blueAccent
                        : Colors.blue[100]!;
                    widget.onLinesSelected(getSelectedLines());
                  });
                },
                child: Container(
                  color: containerColors[index],
                  child: Center(
                    child: Text(
                      widget.items[index].value,
                      style: const TextStyle(fontSize: 15.0),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
