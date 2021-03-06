import 'package:flutter/material.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'package:flutter_login/models/user/bucket.dart';
import 'heart_icon_animator.dart';
import 'ui_utils.dart';

class CommentWidget extends StatefulWidget {
  CommentWidget(this.comment);
  final Comment comment;

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  void _toggleIsLiked() {
    // setState(() => widget.comment.toggleLikeFor(currentUser));
  }

  Text _buildRichText() {
    var currentTextData = StringBuffer();
    var textSpans = <TextSpan>[
      TextSpan(text: '${widget.comment.user.firstName} ', style: bold),
    ];
    widget.comment.content.split(' ').forEach((word) {
      if (word.startsWith('#') && word.length > 1) {
        if (currentTextData.isNotEmpty) {
          textSpans.add(TextSpan(text: currentTextData.toString()));
          currentTextData.clear();
        }
        textSpans.add(TextSpan(text: '$word ', style: link));
      } else {
        currentTextData.write('$word ');
      }
    });
    if (currentTextData.isNotEmpty) {
      textSpans.add(TextSpan(text: currentTextData.toString()));
      currentTextData.clear();
    }
    return Text.rich(TextSpan(children: textSpans),
        maxLines: 3, overflow: TextOverflow.ellipsis);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 5.0),
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 52,
            child: _buildRichText(),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 2),
            child: HeartIconAnimator(
              isLiked: widget.comment.isReactedBy(User.generic),
              size: 14.0,
              onTap: _toggleIsLiked,
            ),
          ),
        ],
      ),
    );
  }
}
