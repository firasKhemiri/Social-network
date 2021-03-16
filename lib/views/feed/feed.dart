import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/feed/bucket.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';
import 'package:flutter_login/views/feed/widgets/feed_main.dart';

import '../../repositories/post/feed_repository.dart';

class Feed extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Feed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feed')),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: RepositoryProvider.value(
            value: FeedRepository,
            child: BlocProvider(
              create: (_) => FeedBloc(
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
    return SizedBox(
      height: 400,
      width: 400,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
              log('state status ${state}');
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
