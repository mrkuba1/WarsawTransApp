// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warsawtransapp/utils/colors.dart';

class BusstopNavWidget extends StatefulWidget {
  const BusstopNavWidget({super.key});

  @override
  _BusstopNavWidgetState createState() => _BusstopNavWidgetState();
}

class _BusstopNavWidgetState extends State<BusstopNavWidget> {
  String get busstopName => "Metro Politechnika 01";

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: busstopNavWidgetNavBar(),
      mobile: mobileNavBar(),
    );
  }

  Widget mobileNavBar() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 70,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        ));
  }

  Widget busstopNavWidgetNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0),
      height: 100,
      child: Container(
        color: AppColors.primary,
        child: Center(
          child: Text(
            busstopName,
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
