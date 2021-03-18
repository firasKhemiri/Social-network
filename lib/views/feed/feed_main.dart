import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/feed/bucket.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/models/feed/feed.dart';
import 'package:flutter_login/views/feed/widgets/bucket.dart';

class FeedMain extends StatefulWidget {
  FeedMain({this.scrollController});
  final ScrollController? scrollController;

  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<FeedMain> {
  List<Post> posts = [];
  List<Story> stories = [];
  Feed feed = Feed.generic;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Builder(
            builder: (
              context,
            ) {
              feed = context.select(
                (FeedBloc bloc) => (bloc.state as FeedLoadSuccess).feed,
              );
              posts = feed.posts;
              stories = feed.stories;
              return _buildBody();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    var deviceSize = MediaQuery.of(context).size;
    log('stories ${stories.length}');
    return Container(
        height: deviceSize.height - 56,
        width: deviceSize.width,
        color: Colors.grey[300],
        child: ListView.builder(
          itemBuilder: (ctx, i) {
            if (i == 0) {
              return StoriesBarWidget(stories);
            }
            return PostWidget(posts[i - 1]);
          },
          itemCount: posts.length + 1,
          controller: widget.scrollController,
        ));
  }
}

class StoriesBarWidget extends StatelessWidget {
  StoriesBarWidget(this.stories);
  final List<Story> stories;

  void _onUserStoryTap(BuildContext context, int i) {
    final message = i == 0
        ? 'Add to Your Story'
        : "View ${stories[i].creator.firstName}'s Story";
    showSnackbar(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, i) {
          return AvatarWidget(
            user: stories[i].creator,
            onTap: () => _onUserStoryTap(context, i),
            isLarge: true,
            isShowingUsernameLabel: true,
            isCurrentUserStory: i == 0,
          );
        },
        itemCount: stories.length,
      ),
    );
  }
}
