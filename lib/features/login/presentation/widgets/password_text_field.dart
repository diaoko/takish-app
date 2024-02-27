import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/form_validator.dart';
import '../cubit/show_password_cubit.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController? passwordController;

  const PasswordField({
    super.key,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return BlocBuilder<ShowPasswordCubit, ShowPasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 5),
                  child: Text(
                    'کلمه عبور',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.bodyLarge!.color,
                      fontFamily: 'IranSans',
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: passwordController,
              validator: (value) => FormValidator.passwordValidator(value),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              obscureText: state.obscureText,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'IranSans',
                color: Colors.black,
              ),
              decoration: InputDecoration(
                isDense: true,
                fillColor: Colors.white,
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
                suffixIcon: GestureDetector(
                  child: context.read<ShowPasswordCubit>().state.obscureText
                      ? Icon(
                          Icons.lock_open,
                          color: Colors.black,
                          size: 30,
                        )
                      : Icon(
                    Icons.lock,
                    color: Colors.black,
                    size: 30,
                  ),
                  onTap: () {
                    context
                        .read<ShowPasswordCubit>()
                        .togglePasswordVisibility();
                  },
                ),
                hintText: 'کلمه عبور',
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
      },
    );
  }
}
