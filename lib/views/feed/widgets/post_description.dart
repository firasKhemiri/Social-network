import 'package:flutter/material.dart';
import 'package:flutter_login/models/feed/bucket.dart';
import 'ui_utils.dart';

class PostDescWidget extends StatelessWidget {
  PostDescWidget(this.comment);
  final Comment comment;

  Text _buildRichText() {
    var currentTextData = StringBuffer();
    var textSpans = <TextSpan>[];
    comment.content.split(' ').forEach((String word) {
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
            child: _buildRichText(),
          ),
        ],
      ),
    );
  }
}
