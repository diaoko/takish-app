import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    super.key,
    required this.onTap,
    required this.isLoading,
    this.text,
    this.color,
  });

  final void Function()? onTap;
  final String? text;
  final bool isLoading;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: size.width * 0.8,
        // margin: const EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color ?? const Color(0xFF0069F7),
        ),
        child: isLoading
            ? const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        )
            : Text(
          text ?? 'OK',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: Colors.white,
            fontFamily: 'IranSans',
          ),
        ),
      ),
    );
  }
}