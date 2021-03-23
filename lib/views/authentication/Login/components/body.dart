import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_login/views/authentication/Login/components/background.dart';
import 'package:flutter_login/views/authentication/Signup/signup_screen.dart';
import 'package:flutter_login/views/authentication/components/already_have_an_account_acheck.dart';
import 'package:flutter_login/views/authentication/components/bucket.dart';
import 'package:flutter_svg/svg.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:flutter_login/blocs/login/bucket.dart';

class Body extends StatelessWidget {
  Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Failure')),
              );
          }
        },
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'LOGIN',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  'assets/icons/login.svg',
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.03),
                _UsernameInput(),
                _PasswordInput(),
                _LoginButton(),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
                OrDivider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SocalIcon(
                      iconSrc: 'assets/icons/facebook.svg',
                      press: () {},
                    ),
                    SocalIcon(
                      iconSrc: 'assets/icons/google-plus.svg',
                      press: () {},
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return RoundedInputField(
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username)),
          key: const Key('loginForm_usernameInput_textField'),
          hintText: 'Your username or email',
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return RoundedPasswordField(
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password)),
          key: const Key('loginForm_passwordInput_textField'),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : RoundedButton(
                key: const Key('loginForm_continue_roundedButton'),
                text: 'LOGIN',
                press: () => state.status.isValidated
                    ? context.read<LoginBloc>().add(const LoginSubmitted())
                    : log('Status is not valid'));
      },
    );
  }
}
