import 'package:flutter/cupertino.dart';

Widget styledText(String text, {required TextStyle testStyle}) {
  final koreanRegex = RegExp(r'[가-힣]');

  final spans = <TextSpan>[];

  for (var i = 0; i < text.length; i++) {
    final char = text[i];

    final bool isKorean = koreanRegex.hasMatch(char);

    final style = testStyle.copyWith(
      fontWeight: isKorean ? FontWeight.w600 : FontWeight.w500,
    );

    spans.add(TextSpan(text: char, style: style));
  }

  return RichText(
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    text: TextSpan(children: spans),
  );
}
