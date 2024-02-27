import 'package:flutter/material.dart';

class DrawerExpansionTile extends StatelessWidget {
  const DrawerExpansionTile({
    super.key,
    required this.text,
    this.iconPath,
    this.fontSize = 16,
    this.children = const <Widget>[],
  });

  final String text;
  final String? iconPath;
  final double fontSize;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      // expandedAlignment: Alignment.centerRight,
      // collapsedBackgroundColor: Colors.red,
      // backgroundColor: Colors.white,
      title: Row(
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
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontFamily: 'IranSans',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      children: children,
      // [
      //   Padding(
      //     padding: const EdgeInsets.only(left: 16),
      //     child: ExpansionTile(
      //       title: Row(
      //         children: [
      //           Image.asset(
      //             'assets/icons/iconBaseInfo.png',
      //             height: 25,
      //             width: 25,
      //           ),
      //           const SizedBox(width: 16),
      //           Text(
      //             'Sale',
      //             style: TextStyle(fontSize: 14),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // Container(
      //   width: double.infinity,
      //   padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
      //   child: GestureDetector(
      //     onTap: () {},
      //     child: Text('MedicineDB'),
      //   ),
      // ),
      //   Container(
      //     width: double.infinity,
      //     padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
      //     child: GestureDetector(
      //       onTap: () {},
      //       child: Text('Customers'),
      //     ),
      //   ),
      //   Container(
      //     width: double.infinity,
      //     padding: EdgeInsets.only(left: 30, top: 10, bottom: 10),
      //     child: GestureDetector(
      //       onTap: () {},
      //       child: Text('Suppliers'),
      //     ),
      //   ),
      // ],
    );
  }
}
