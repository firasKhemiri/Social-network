import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/blocs/feed/bucket.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/repositories/feed/feed_repository.dart';
import 'package:flutter_login/views/feed/feed_main.dart';

import '../../repositories/feed/feed_repository.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: RepositoryProvider.value(
            value: FeedRepository,
            child: BlocProvider(
              create: (_) => FeedBloc(
                  authenticationBloc: context.read<AuthenticationBloc>(),
                  authenticationRepository:
                      context.read<AuthenticationRepository>(),
                  feedRepository: FeedRepository())
                ..add(FeedStatusChanged(FeedStatus.load)),
              child: FeedView(),
            )),
      ),
    );
  }
}

class FeedView extends StatefulWidget {
  @override
  _FeedViewState createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      height: deviceSize.height,
      width: deviceSize.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
              log('state status $state');
              if (state is FeedLoading) {
                return const CircularProgressIndicator();
              }
              if (state is FeedLoadSuccess) {
                return FeedMain();
              }
              if (state is FeedLoadFailure) {
                return Text('${state.message}');
              }
              return const Text('Something went wrong');
            }),
          ],
        ),
      ),
    );
  }
}
