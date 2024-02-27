import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/api_urls.dart';
import '../../../core/constants/storage_constants.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';
import 'cubit/show_password_cubit.dart';
import 'widgets/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  late String _localPath;
  late TargetPlatform? platform;

  @override
  void initState() {
    super.initState();

    var settingsBox = Hive.box(HiveBoxes.settingsBox);
    settingsBox.put(HiveKeys.ipAddress,
        settingsBox.get(HiveKeys.ipAddress, defaultValue: ApiUrls.baseUrl));

    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShowPasswordCubit(),
        ),
      ],
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: Scaffold(
          backgroundColor: const Color(0xFF0D0D0D),
          body: SafeArea(
            child: SingleChildScrollView(
              reverse: true,
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                width: size.width,
                // padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is LoginStartingState) {
                      usernameController.text = state.username;
                      passwordController.text = state.password;

                      return LoginForm(
                        formKey: formKey,
                        usernameController: usernameController,
                        passwordController: passwordController,
                      );
                    } else {
                      return LoginForm(
                        formKey: formKey,
                        usernameController: usernameController,
                        passwordController: passwordController,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
