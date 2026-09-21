import 'package:flutter/material.dart';

List<TextSpan> highlightMatch(
  String text,
  String query,
  TextStyle defaultStyle,
  TextStyle highlightStyle,
) {
  if (query.isEmpty || !text.toLowerCase().contains(query.toLowerCase())) {
    return [TextSpan(text: text, style: defaultStyle)];
  }

  final List<TextSpan> spans = [];
  final String lowerText = text.toLowerCase();
  final String lowerQuery = query.toLowerCase();

  int start = 0;
  int indexOfMatch = lowerText.indexOf(lowerQuery);

  while (indexOfMatch != -1) {
    if (indexOfMatch > start) {
      spans.add(
        TextSpan(
          text: text.substring(start, indexOfMatch),
          style: defaultStyle,
        ),
      );
    }

    final matchEnd = indexOfMatch + query.length;
    spans.add(
      TextSpan(
        text: text.substring(indexOfMatch, matchEnd),
        style: highlightStyle,
      ),
    );

    start = matchEnd;
    indexOfMatch = lowerText.indexOf(lowerQuery, start);
  }

  if (start < text.length) {
    spans.add(TextSpan(text: text.substring(start), style: defaultStyle));
  }

  return spans;
}
