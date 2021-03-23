import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/common/routes/size.dart';
import 'package:flutter_login/views/authentication/Welcome/welcome_screen.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';
import 'package:flutter_login/repositories/user/user_repository.dart';
import 'package:flutter_login/views/home/home.dart';
import 'package:flutter_login/views/splash/splash.dart';

import 'blocs/authentication/bucket.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
    required this.feedRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;
  final FeedRepository feedRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
          create: (_) => AuthenticationBloc(
            authenticationRepository: authenticationRepository,
            userRepository: userRepository,
          ),
          child: AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              _navigatorKey.currentState!
                  .pushAndRemoveUntil<void>(Home.route(), (route) => false);
            }
            if (state is AuthenticationFailure) {
              _navigator!.pushAndRemoveUntil<void>(
                SizeRoute(page: WelcomeScreen()),
                (route) => false,
              );
            }
            // case AuthenticationSuccess:
            // _navigator.pushAndRemoveUntil<void>(
            //   Feed.route(),
            //   (route) => false,
            // );
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
