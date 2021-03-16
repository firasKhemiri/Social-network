import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/authentication/bucket.dart';
import 'package:flutter_login/blocs/feed/bucket.dart';

class FeedMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Builder(
            builder: (context) {
              final postId = context.select(
                (FeedBloc bloc) =>
                    (bloc.state as FeedLoadSuccess).feed.posts[0].id,
              );
              return Text('PostID: $postId');
              // (state as FeedLoadedSuccess).posts
            },
          ),
          RaisedButton(
            child: const Text('Logout'),
            onPressed: () {
              context
                  .read<AuthenticationBloc>()
                  .add(AuthenticationLogoutRequested());
            },
          ),
        ],
      ),
    );
  }
}
