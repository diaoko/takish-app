import 'package:flutter/material.dart';

import '../../../../core/utils/form_validator.dart';

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({
    super.key,
    required this.usernameController,
    this.autofocus,
  });

  final TextEditingController usernameController;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    // var themeMode = context.watch<ThemeCubit>().state;
    // bool isDarkMode = themeMode == ThemeMode.dark;
    var theme = Theme.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 5),
              child: Text(
                'نام کاربری',
                style: TextStyle(
                  color: theme.textTheme.bodyLarge!.color,
                  fontSize: 18,
                  fontFamily: 'IranSans',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          autofocus: autofocus ?? false,
          controller: usernameController,
          validator: (value) => FormValidator.usernameValidator(value),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(
            fontSize: 14,
            fontFamily: 'IranSans',
            color: Colors.black,
          ),
          decoration: InputDecoration(
            fillColor: Colors.white,
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffbdbdbd),
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            filled: true,
            suffixIcon: Icon(
              Icons.person,
              color: Colors.black,
              size: 30,
            ),
            hintText: 'نام کاربری',
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontFamily: 'IranSans',
              fontWeight: FontWeight.normal,
            ),
            errorStyle: const TextStyle(
              color: Colors.orange,
            ),
          ),
        ),
      ],
    );
  }
}
