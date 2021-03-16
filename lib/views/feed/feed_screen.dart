import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/feed/bucket.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/views/feed/widgets/bucket.dart';

class FeedScreen extends StatefulWidget {
  final ScrollController scrollController;

  FeedScreen({required this.scrollController});

  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<FeedScreen> {
  List<Post> posts = [];
  List<Story> stories = [];

  @override
  void initState() {
    super.initState();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Feed'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedBloc, FeedState>(
      builder: (BuildContext context, FeedState state) {
        if (state is FeedLoading) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: const LinearProgressIndicator(),
          );
        } else if (state is FeedLoadFailure) {
          return Scaffold(
            appBar: _buildAppBar(),
            body: const Center(child: Text('state.error')),
          );
        } else {
          posts = (state as FeedLoadSuccess).feed.posts;
          stories = (state as FeedLoadSuccess).feed.stories;
          return Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody(),
          );
        }
      },
    );
  }

  Widget _buildBody() {
    return Container(
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
