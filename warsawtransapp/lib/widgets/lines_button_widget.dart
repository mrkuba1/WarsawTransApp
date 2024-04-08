


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
  child: GridView.builder(
  itemCount: widget.items.length - 1, // Liczba elementów w siatce
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  crossAxisCount: 5, // Liczba kolumn w siatce
  crossAxisSpacing: 10.0, // Odległość pomiędzy kolumnami
  mainAxisSpacing: 10.0, // Odległość pomiędzy wierszami
  childAspectRatio: 0.5 / 0.5, // Proporcja szerokość / wysokość
  ),
  itemBuilder: (BuildContext context, int index) {
  // Tworzenie i zwracanie elementu siatki
  return GestureDetector(
  onTap: () {
  // Obsługa kliknięcia
  setState(() {
  if (isToggled[index]) {
  containerColors[index] =
  Colors.blue[100]!; // Przywracamy pierwotny kolor
  } else {
  containerColors[index] =
  Colors.blueAccent; // Zmieniamy kolor na czerwony
  }
  isToggled[index] =
  !isToggled[index]; // Odwracamy stan wciśnięcia

  widget.onLinesSelected(getSelectedLines());
  // print(getSelectedLines());
  });
  },
  child: Container(
  color: containerColors[index],
  child: Center(
  child: Text(
  widget.items[index + 1].value,
  style: const TextStyle(fontSize: 15.0),
  ),
  ),
  ),
  );
  },
  ),
  );
  }
  }


