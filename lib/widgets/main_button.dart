import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.color,
    this.textColor,
    // this.isOutlined = false,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? color;
  final Color? textColor;
  // final bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        margin: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        padding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 10,
          bottom: 10,
        ),
        decoration: BoxDecoration(
          color: color ?? Colors.deepOrange,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFF0069F7)),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? const SizedBox(
          height: 45,
          width: 25,
          child: Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        )
            : Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: 'IranSans',
          ),
        ),
      ),
    );
  }
}
