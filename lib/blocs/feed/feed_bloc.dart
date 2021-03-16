import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/repositories/auth/authentication_repository.dart';
import 'package:flutter_login/repositories/post/feed_repository.dart';

import 'feed_events.dart';
import 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvents, FeedState> {
  FeedBloc({
    required AuthenticationRepository authenticationRepository,
    required FeedRepository feedRepository,
  })   : _authenticationRepository = authenticationRepository,
        _feedRepository = feedRepository,
        super(FeedLoading()) {
    _feedStatusSubscription = _feedRepository.status.listen(
      (status) => add(FeedStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final FeedRepository _feedRepository;
  late StreamSubscription<FeedStatus> _feedStatusSubscription;

  @override
  Stream<FeedState> mapEventToState(
    FeedEvents event,
  ) async* {
    if (event is FeedStatusChanged) {
      yield* _mapAuthenticationStatusChangedToState(event);
    }
  }

  @override
  Future<void> close() {
    _feedStatusSubscription.cancel();
    _feedRepository.dispose();
    return super.close();
  }

  Stream<FeedState> _mapAuthenticationStatusChangedToState(
    FeedStatusChanged event,
  ) async* {
    if (event.status == FeedStatus.load) {
      yield* _fetchFeed(event);
    }

    // if (event.status == FeedStatus.loading) {
    //   yield* _mapFeedLoadingToState(event);
    // }
  }

  Stream<FeedState> _fetchFeed(FeedStatusChanged event,
      {int retries = 0}) async* {
    // yield FeedLoading();
    try {
      final feed = await _feedRepository.getFeed();
      yield FeedLoadSuccess(feed);
    } catch (e) {
      log('fail num: $retries ${e.toString()}');
      retries++;

      if (retries < 2)
        try {
          await _authenticationRepository.signInWithRefreshToken();
          yield* _fetchFeed(event, retries: retries);
        } catch (e) {
          yield const FeedLoadFailure(message: 'Failed to authenticate');
          log('Failed to authenticate');
        }
      else {
        yield const FeedLoadFailure(message: 'Error: Max retries exceeded');
        // _authenticationRepository.logOut();
      }
    }
  }

  // Stream<FeedState> _mapFeedLoadedToState(Post feed) async* {
  //   yield FeedLoadSuccess(feed: feed);
  // }

  // Stream<FeedState> _mapFeedLoadingToState(FeedStatusChanged event) async* {
  //   yield FeedLoading();
  // }

  // Stream<FeedState> _mapFeedNotLoadededToState(String message) async* {
  //   yield FeedLoadFailure(message: message);
  // }
}
