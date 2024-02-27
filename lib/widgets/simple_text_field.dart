import 'package:flutter/material.dart';

class SimpleTextField extends StatelessWidget {
  const SimpleTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      keyboardType: keyboardType ?? TextInputType.name,
      readOnly: readOnly,
      decoration: const InputDecoration(
        filled: false,
        hintText: 'جستوجو',
        hintStyle: TextStyle(
          color: Colors.black,
          fontFamily: 'IranSans',
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}