import 'package:flutter/material.dart';
import 'package:warsawtransapp/widgets/nav_bus_widget.dart';
import 'package:warsawtransapp/widgets/nav_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> items = [
    "P",
    "A",
    "B",
    "C",
    "D",
    "A",
    "B",
    "C",
    "D",
    "A",
    "B",
    "C",
    "D",
    "A",
    "B",
    "C",
    "D"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  child: const NavWidget(),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  child: const BusstopNavWidget(),
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.height / (4 / 3),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / (4 / 3),
                  height: MediaQuery.of(context).size.height / (4 / 3),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
