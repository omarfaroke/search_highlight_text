
<p >
  <a href="https://pub.dev/packages/search_highlight_text"><img src="https://img.shields.io/pub/v/search_highlight_text"></a>
</p>

Simple Inherited Widget to highlight text in a search result, with custom highlight Color and highlight TextStyle.

## Features

- Highlight text in a search result with custom highlight Color and highlight TextStyle.
- Highlight text in a search result without prasing the search text directly.
- Parse the search text as a regular expression.

## Usage

```dart
 SearchTextInheritedWidget(
  searchText: 'search text',
  child: SearchHighlightText('text to highlight'),
 ),
 
 // or
SearchTextInheritedWidget(
  // you can use any RegExp here, like RegExp('[1-9]'), RegExp('search text with RegExp', caseSensitive: false), etc.
  searchRegExp: RegExp('search text with RegExp'), 
  child: SearchHighlightText('text to highlight'),
),
```

you can also use `SearchHighlightText` directly, but you need to provide the `searchText` or `searchRegExp` to it.

```dart
SearchHighlightText(
  'text to highlight',
  searchText: 'search text',
),
```

## Example

See full example in [repo](https://github.com/omarfaroke/search_highlight_text/tree/main/example).

```dart
// search_view.dart

class SearchView extends ConsumerWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var controller = ref.watch(searchController);

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: const Text('Search Movies Example'),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SearchField(
              controller: controller,
            ),
            Expanded(
              child: controller.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SearchTextInheritedWidget(
                      searchText: controller
                          .searchText, // <-- Here we pass the search text to the widget tree to be used by the SearchHighlightText widget
                      child: ListMoviesWidget(
                        listMovies: controller.movies,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
```
  
```dart
// movie_card.dart

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: SearchHighlightText( // <-- Here we use the SearchHighlightText widget to highlight the search text (if any) in the movie title
          movie.title,
        ),
        subtitle: Text(movie.year),
        leading: SizedBox(
          width: 100,
          child: Image.network(
            movie.posterUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error);
            },
          ),
        ),
      ),
    );
  }
}

```

<p>
<img width="300" height="600" src="https://raw.githubusercontent.com/omarfaroke/search_highlight_text/main/example/screenshots/example.gif">
</p>
