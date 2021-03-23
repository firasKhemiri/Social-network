import 'package:equatable/equatable.dart';
import 'package:flutter_login/models/feed/feed.dart';

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
