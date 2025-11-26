import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension LocalizedFinders on CommonFinders {
  Finder byLocalizedText(
    String Function(BuildContext) text, {
    bool isRichText = false,
    bool isAutoSize = false,
    bool skipOffstage = true,
  }) {
    return byElementPredicate((element) {
      final widget = element.widget;
      if (isRichText) {
        return widget is RichText && widget.text.toPlainText() == text(element);
      }
      if (isAutoSize && widget.runtimeType.toString() == 'AutoSizeText') {
        final data = (widget as dynamic).data as String?;
        return data == text(element);
      }
      return widget is Text && widget.data == text(element);
    }, skipOffstage: skipOffstage);
  }
}
