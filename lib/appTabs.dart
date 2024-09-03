// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Apptabs extends StatelessWidget {
  final Color color;
  final String text;
  const Apptabs({
    Key? key,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: color,
        ),
        width: 120,
        
        alignment: Alignment.center,
        height: 40,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white
          ),
        ),
      );
  }
}
