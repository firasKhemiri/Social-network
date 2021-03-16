import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/models/feed/feed.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';

// class FeedState extends Equatable {
//   const FeedState._(
//       {this.status = FeedStatus.notloaded, this.post, this.message});

//   const FeedState.load() : this._(status: FeedStatus.load);

//   const FeedState.loading() : this._(status: FeedStatus.loading);

//   const FeedState.loaded(Post post)
//       : this._(status: FeedStatus.loaded, post: post);

//   const FeedState.notLoaded(String message)
//       : this._(status: FeedStatus.notloaded, message: message);

//   final FeedStatus status;
//   final Post? post;
//   final String? message;

//   @override
//   List<Object> get props => [status, post!, message!];
// }

abstract class FeedState extends Equatable {
  const FeedState();
  @override
  List<Object> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoadSuccess extends FeedState {
  FeedLoadSuccess(this.feed) : super();
  final Feed feed;

  @override
  List<Object> get props => [feed];
}

class FeedLoadFailure extends FeedState {
  const FeedLoadFailure({required this.message});
  final String message;
  @override
  List<Object> get props => [message];
}
