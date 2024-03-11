// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class FoodCategoryWidget extends StatelessWidget {
  final String icon;
  final String name;
  final bool isSelected;
  const FoodCategoryWidget({
    Key? key,
    required this.icon,
    this.isSelected = false,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: isSelected ? Colors.blueAccent.shade400 : Colors.grey.shade300,
        border: Border.all(color: Colors.white30, width: 2),
        borderRadius: BorderRadius.circular(25),
      ),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            icon,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 20,
              color: isSelected ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
