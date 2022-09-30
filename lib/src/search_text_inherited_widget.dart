import 'package:flutter/material.dart';

/// Used to share search text between widgets in the widget tree using [InheritedWidget] pattern.
///
/// you can use this widget to pass the search text to the [SearchHighlightText] widget, without passing parameters to the [SearchHighlightText] widget directly.
///
///
/// Example:
///
/// ```dart
/// SearchTextInheritedWidget(
///  searchText: 'search text',
/// child: ... // your widgets
/// )
/// ```
/// you can also pass the search text as a RegExp:
///
/// ```dart
/// SearchTextInheritedWidget(
/// searchRegExp: RegExp('search text with RegExp'), // you can use any RegExp here, like RegExp('[1-9]'), RegExp('search text with RegExp', caseSensitive: false), etc.
/// child: ... // your widgets
/// )
/// ```
///
///
/// then you can use the [SearchHighlightText] widget without passing the search text to it.
///
/// ```dart
/// SearchHighlightText('text to highlight')
/// ```
///
///
///
class SearchTextInheritedWidget extends InheritedWidget {
  const SearchTextInheritedWidget({
    Key? key,
    String? searchText,
    RegExp? searchRegExp,
    this.highlightStyle,
    this.highlightColor = Colors.red,
    required Widget child,
  })  : _searchText = searchText,
        _searchRegExp = searchRegExp,
        assert(searchText != null || searchRegExp != null),
        assert(searchText == null || searchRegExp == null),
        super(key: key, child: child);

  final String? _searchText;
  final TextStyle? highlightStyle;
  final Color highlightColor;
  final RegExp? _searchRegExp;

  static SearchTextInheritedWidget of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SearchTextInheritedWidget>()!;
  }

  static SearchTextInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<SearchTextInheritedWidget>();
  }

  RegExp get searchRegExp {
    if (_searchRegExp != null) {
      return _searchRegExp!;
    }
    return RegExp(_searchText!, caseSensitive: false);
  }

  @override
  bool updateShouldNotify(SearchTextInheritedWidget oldWidget) {
    return _searchText != oldWidget._searchText;
  }
}
