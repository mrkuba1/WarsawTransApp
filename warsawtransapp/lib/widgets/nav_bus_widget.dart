import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warsawtransapp/utils/colors.dart';

class BusstopNavWidget extends StatefulWidget {
  final String name;
  const BusstopNavWidget({Key? key, required this.name}) : super(key: key);

  @override
  _BusstopNavWidgetState createState() => _BusstopNavWidgetState();
}

class _BusstopNavWidgetState extends State<BusstopNavWidget> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: busstopNavWidgetNavBar(widget.name),
      mobile: mobileNavBar(),
    );
  }

  Widget mobileNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [],
      ),
    );
  }

  Widget busstopNavWidgetNavBar(String name) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      height: 100,
      child: Container(
        color: AppColors.primary,
        child: Center(
          child: Text(
            name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 35,
            ),
          ),
        ),
      ),
    );
  }
}
