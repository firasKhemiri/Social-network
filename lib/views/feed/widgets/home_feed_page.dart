// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:flutter_experience/Insta/post_widget.dart';
// import 'package:flutter_experience/Insta/ui_utils.dart';
// import 'package:flutter_experience/services/model/post.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';

// import 'avatar_widget.dart';
// import '../common/queries/posts_queries.dart';
// import 'graphql_config.dart';

// class HomeFeedPage extends StatefulWidget {
//   final ScrollController scrollController;

//   HomeFeedPage({this.scrollController});

//   @override
//   _HomeFeedPageState createState() => _HomeFeedPageState();
// }

// class _HomeFeedPageState extends State<HomeFeedPage> {
//   final posts = <Post>[];

//   GraphQLConfiguration graphQLConfiguration = GraphQLConfiguration();

//   void fillList() async {
//     log('starting query');

//     QueryMutation queryMutation = QueryMutation();
//     GraphQLClient _client = graphQLConfiguration.clientToQuery();

//     QueryResult result = await _client.query(
//       QueryOptions(
//         documentNode: gql(queryMutation.getPostsQuery()),
//       ),
//     );

//     log('query sent');

//     if (!result.hasException) {
//       for (var i = 0; i < result.data["posts"].length; i++) {
//         setState(() {
//           posts.add(Post.fromJson(result.data["posts"][i]));
//         });
//       }
//     } else {
//       log('data: ' + result.exception.toString());
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fillList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.grey[300],
//         child: ListView.builder(
//           itemBuilder: (ctx, i) {
//             if (i == 0) {
//               return StoriesBarWidget();
//             }
//             return PostWidget(posts[i - 1]);
//           },
//           itemCount: posts.length + 1,
//           controller: widget.scrollController,
//         ));
//   }
// }

// class StoriesBarWidget extends StatelessWidget {
//   void _onUserStoryTap(BuildContext context, int i) {
//     final message =
//         i == 0 ? 'Add to Your Story' : "View ${_users[i].name}'s Story";
//     showSnackbar(context, message);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 106.0,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemBuilder: (ctx, i) {
//           return AvatarWidget(
//             user: _users[i],
//             onTap: () => _onUserStoryTap(context, i),
//             isLarge: true,
//             isShowingUsernameLabel: true,
//             isCurrentUserStory: i == 0,
//           );
//         },
//         itemCount: _users.length,
//       ),
//     );
//   }
// }
