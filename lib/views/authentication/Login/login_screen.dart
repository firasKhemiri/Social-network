import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/blocs/login/bucket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/views/authentication/Login/components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context),
              authenticationBloc: context.read<AuthenticationBloc>());
        },
        child: Body(),
      ),
    );
  }
}
