import 'package:flutter/material.dart';

class DrawerSimpleTile extends StatelessWidget {
  const DrawerSimpleTile({
    super.key,
    required this.text,
    required this.onTap,
    this.iconPath,
    this.fontSize = 14,
  });

  final String text;
  final String? iconPath;

  final void Function()? onTap;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsetsDirectional.only(
          start: 32,
          end: 0,
        ),
        child: Row(
          children: [
            Visibility(
              visible: iconPath == null ? false : true,
              child: Image.asset(
                iconPath ?? '',
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize,
                  fontFamily: 'IranSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
