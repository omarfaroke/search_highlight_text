import 'package:example/search/views/search_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Search Highlight Text Example',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SearchView(),
      ),
    );
  }
}
