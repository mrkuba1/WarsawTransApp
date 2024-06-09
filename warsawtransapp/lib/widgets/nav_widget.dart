import 'package:flutter/material.dart';
import 'package:warsawtransapp/utils/colors.dart';

class NavWidget extends StatelessWidget {
  const NavWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondary,
      margin: const EdgeInsets.symmetric(vertical: 0),
      height: 100,
      child: const Center(
        child: Text(
          "Dynamiczna informacja pasażerska cos jeszcze",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
