import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/blocs/authentication/authentication_bloc.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/models/user/bucket.dart';
import '../../../env.dart';
import 'bucket.dart';
// import 'heart_icon_animator.dart';
// import 'heart_overlay_animator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'avatar_widget.dart';
import 'ui_utils.dart';

class PostWidget extends StatefulWidget {
  PostWidget(this.post);
  final Post post;

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  final StreamController<void> _doubleTapImageEvents =
      StreamController.broadcast();
  bool _isSaved = false;
  int _currentImageIndex = 0;

  @override
  void dispose() {
    _doubleTapImageEvents.close();
    super.dispose();
  }

  void _updateImageIndex(int index, CarouselPageChangedReason reason) {
    setState(() => _currentImageIndex = index);
  }

  void _onDoubleTapLikePhoto() {
    // setState(() => widget.post.addLikeIfUnlikedFor(currentUser));
    _doubleTapImageEvents.sink.add(null);
  }

  void _toggleIsLiked() {
    // setState(() => widget.post.toggleLikeFor(currentUser));
  }

  void _toggleIsSaved() {
    setState(() => _isSaved = !_isSaved);
  }

  void _showAddCommentModal(User user) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddCommentModal(
            // TODO change to actual user
            user: user,
            onPost: (String text) {
              setState(() {
                widget.post.comments!.add(Comment(
                  content: text,
                  dateCreated: DateTime.now(),
                  // TODO Change user to current user
                  reactions: [], id: 1,
                  user: user,
                ));
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var user = (BlocProvider.of<AuthenticationBloc>(context).state
            as AuthenticationSuccess)
        .user;
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        margin: const EdgeInsets.only(top: 20, bottom: 10),
        child: Column(
          children: <Widget>[
            Container(
                height: 40,
                child: Stack(overflow: Overflow.visible, children: [
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    top: -25.0,
                    right: 133.0,
                    child: AvatarWidget(user: widget.post.creator),
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    height: 50.0,
                    top: 0,
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 77, top: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.post.creator.getFullName(),
                                    style: bold),
                                Container(height: 2),
                                if (widget.post.location != null)
                                  Text(
                                    widget.post.location!,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 11),
                                  ),
                                Text(
                                  widget.post.timeAgo(),
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.0),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            padding: const EdgeInsets.only(bottom: 10),
                            icon: const Icon(Icons.more_vert),
                            onPressed: () => showSnackbar(context, 'More'),
                          )
                        ],
                      ),
                    ),
                  ),
                ])),

            // if (widget.post.comments != null &&
            //     widget.post.comments!.isNotEmpty)
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 12),
            //     child: Column(
            //       children: widget.post.comments!
            //           .map((Comment c) => PostDescWidget(c))
            //           .toList(),
            //     ),
            //   ),

            // Photo Carosuel
            GestureDetector(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  CarouselSlider(
                      items: widget.post.images!.map((image) {
                        return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            child: CachedNetworkImage(
                              imageUrl: Env.staticUrl + image.path,
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, placeholderURL, error) =>
                                  const Icon(Icons.error),
                            ));
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: _updateImageIndex,
                      )),
                  HeartOverlayAnimator(
                      triggerAnimationStream: _doubleTapImageEvents.stream),
                ],
              ),
              onDoubleTap: _onDoubleTapLikePhoto,
            ),

            // Action Bar
            Container(
              height: 30,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: HeartIconAnimator(
                      // TODO Fix user
                      isLiked: widget.post.isReactedBy(user),
                      size: 28.0,
                      onTap: _toggleIsLiked,
                      triggerAnimationStream: _doubleTapImageEvents.stream,
                    ),
                  ),
                  Container(
                    width: 35,
                    child: Text('${widget.post.reactions.length}', style: bold),
                  ),
                  if (widget.post.reactions.length > 1) ...[
                    Text(widget.post.reactions[0].user.firstName, style: bold),
                    Text(' and'),
                    Text(' ${widget.post.reactions.length - 1} others',
                        style: bold),
                  ],
                  Container(
                    width: 30,
                    child: IconButton(
                      padding: const EdgeInsets.only(right: 10),
                      iconSize: 28.0,
                      icon: const Icon(Icons.chat_bubble_outline),
                      onPressed: () => _showAddCommentModal(user),
                    ),
                  ),
                  Container(
                      width: 20,
                      child: Text(widget.post.comments!.length.toString(),
                          style: bold)),
                  const Spacer(),
                  if (widget.post.images!.length > 1)
                    PhotoCarouselIndicator(
                      photoCount: widget.post.images!.length,
                      activePhotoIndex: _currentImageIndex,
                    ),
                  const Spacer(),
                  const Spacer(),
                  const Spacer(),
                  IconButton(
                    padding: EdgeInsets.zero,
                    iconSize: 28.0,
                    icon: _isSaved
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_border),
                    onPressed: _toggleIsSaved,
                  )
                ],
              ),
            ),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Comments
                  if (widget.post.comments!.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // border:
                        //     Border.all(color: Colors.grey[300], width: 1.0)
                      ),
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 5.0, left: 16, right: 0),
                      child: Column(
                        children: widget.post.comments!
                            .map((Comment c) => CommentWidget(c))
                            .toList(),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ));
  }
}

class PhotoCarouselIndicator extends StatelessWidget {
  PhotoCarouselIndicator({
    required this.photoCount,
    required this.activePhotoIndex,
  });
  final int photoCount;
  final int activePhotoIndex;

  Widget _buildDot({required bool isActive}) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: isActive ? 7.5 : 6.0,
          width: isActive ? 7.5 : 6.0,
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(photoCount, (i) => i)
          .map((i) => _buildDot(isActive: i == activePhotoIndex))
          .toList(),
    );
  }
}

class AddCommentModal extends StatefulWidget {
  AddCommentModal({required this.user, required this.onPost});
  final User user;
  final ValueChanged<String> onPost;

  @override
  _AddCommentModalState createState() => _AddCommentModalState();
}

class _AddCommentModalState extends State<AddCommentModal> {
  final _textController = TextEditingController();
  bool _canPost = false;

  @override
  void initState() {
    _textController.addListener(() {
      setState(() => _canPost = _textController.text.isNotEmpty);
    });
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        AvatarWidget(user: widget.user),
        Expanded(
          child: TextField(
            controller: _textController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Add a comment...',
              border: InputBorder.none,
            ),
          ),
        ),
        FlatButton(
          child: Opacity(
            opacity: _canPost ? 1.0 : 0.4,
            child: const Text('Post', style: TextStyle(color: Colors.blue)),
          ),
          onPressed:
              _canPost ? () => widget.onPost(_textController.text) : null,
        )
      ],
    );
  }
}
