import 'package:flutter/material.dart';

class OutlineBorderTextfeild extends StatelessWidget {
  final String label;
  final IconData prefixIcon;

  const OutlineBorderTextfeild({
    Key key,
    this.label,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          prefixIcon: Icon(
            prefixIcon,
            size: 15,
          ),
          labelText: label,
          labelStyle: TextStyle(),
        ),
      ),
    );
  }
}
