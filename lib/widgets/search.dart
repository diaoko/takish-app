import 'package:flutter/material.dart';
import 'package:ticket/widgets/simple_text_field.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
    });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: size.width,
        height: 40,
        padding: const EdgeInsetsDirectional.only(start: 5, end: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(start: 5, end: 5),
                child: Container(
                  color: Colors.transparent,
                  child: SimpleTextField(
                    controller: TextEditingController(),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.search,
            ),
          ],
        ),
      ),
    );
  }
}
