import 'package:flutter/material.dart';

import 'search_text_inherited_widget.dart';

/// This widget is used to highlight the search text in the text widget
/// before using this widget you must use the [SearchTextInheritedWidget] to pass the search text
/// to this widget, or you can pass the search text directly to this widget.
///
/// you can also provide the [highlightStyle] to customize the highlight style
/// if you don't provide the [highlightStyle] the default style will be used,
/// The default style is [SearchTextInheritedWidget.maybeOf(context)?.highlightStyle ?? TextStyle(color: Colors.red,)]
///
/// Example:
///
/// ```dart
/// SearchTextInheritedWidget(
/// searchText: 'search text',
/// child: SearchHighlightText('text to highlight')
/// )
/// ```
///
/// or
///
/// ```dart
/// SearchHighlightText('text to highlight', searchText: 'search text')
/// ```
///
/// you can also pass the search text as a RegExp:
/// ```dart
/// SearchHighlightText(
/// 'text to highlight',
/// searchRegExp: RegExp('search text with RegExp'), // you can use any RegExp here, like RegExp('[1-9]'), RegExp('search text with RegExp', caseSensitive: false), etc.
/// )
/// ```
///
class SearchHighlightText extends StatelessWidget {
  const SearchHighlightText(
    this.text, {
    Key? key,
    this.searchText,
    this.searchRegExp,
    this.style,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.textScaleFactor,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.highlightStyle,
  })  : assert(searchText == null || searchRegExp == null),
        super(key: key);

  final String text;
  final String? searchText;
  final RegExp? searchRegExp;
  final TextStyle? style;
  final TextStyle? highlightStyle;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final double? textScaleFactor;
  final Locale? locale;
  final StrutStyle? strutStyle;
  final TextWidthBasis? textWidthBasis;

  @override
  Widget build(BuildContext context) {
    final inheritedWidget = SearchTextInheritedWidget.maybeOf(context);
    RegExp? searchRegExp = searchText != null
        ? RegExp(searchText!)
        : (this.searchRegExp ?? inheritedWidget?.searchRegExp);

    if (searchRegExp == null || searchRegExp.pattern.isEmpty) {
      return Text(
        text,
        style: style,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        textDirection: textDirection,
        softWrap: softWrap,
        textScaleFactor: textScaleFactor,
        locale: locale,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis,
      );
    }

    final highlightStyle = this.highlightStyle ??
        ((inheritedWidget?.highlightStyle) ??
            (style != null
                ? style!.copyWith(
                    color: inheritedWidget?.highlightColor ?? Colors.red,
                  )
                : DefaultTextStyle.of(context).style.copyWith(
                      color: inheritedWidget?.highlightColor ?? Colors.red,
                    )));

    final textSpans = <TextSpan>[];
    var lastEnd = 0;
    for (final match in searchRegExp.allMatches(text)) {
      if (match.start > lastEnd) {
        textSpans.add(
          TextSpan(
            text: text.substring(lastEnd, match.start),
            style: style ?? DefaultTextStyle.of(context).style,
          ),
        );
      }
      textSpans.add(
        TextSpan(
          text: text.substring(match.start, match.end),
          style: highlightStyle,
        ),
      );
      lastEnd = match.end;
    }
    if (lastEnd < text.length) {
      textSpans.add(
        TextSpan(
          text: text.substring(lastEnd),
          style: style ?? DefaultTextStyle.of(context).style,
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.clip,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      softWrap: softWrap ?? true,
      textScaleFactor: textScaleFactor ?? 1.0,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? TextWidthBasis.parent,
    );
  }
}
