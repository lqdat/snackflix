import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movieproject/api/movieapi.dart';

import 'package:movieproject/models/movies.dart';

class MultiSearchScreen extends StatefulWidget {
  @override
  _MultiSearchScreenState createState() => _MultiSearchScreenState();
}

class _MultiSearchScreenState extends State<MultiSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Movies> searchResults = [];
  bool isLoading = false;
  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    setState(() {
      isLoading = true;
    });

    await MovieApi().getSearchMovies(query).then((value) => setState(() {
          searchResults = value;
          isLoading = false;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm kiếm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _searchController,
              onFieldSubmitted: (value) {
                
              },
              onChanged:(value){
                setState(() {
                  _searchController.text=value;
                  _performSearch(_searchController.text);
                });
              } ,
              decoration: InputDecoration(
                labelText: 'Nhập tên phim....',
                
                // suffixIcon: IconButton(
                //   icon: Icon(Icons.search),
                //   onPressed: () {
                //     _performSearch(_searchController.text);
                //   },
                // ),
              ),
            ),
            _searchController.text.isNotEmpty?
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final result = searchResults[index];
                  return ListTile(
                    // onTap: () {
                    //   // Navigate to the appropriate detail screen
                    //   if (result['media_type'] == 'movie') {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) =>
                    //             DetailScreen(movie: Movie.fromJson(result)),
                    //       ),
                    //     );
                    //   } else if (result['media_type'] == 'tv') {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => SeriesDetailScreen(
                    //             series: Series.fromJson(result)),
                    //       ),
                    //     );
                    //   }
                    // },
                    leading: result.poster_url != null
                        ? SizedBox(
                            width: 56,
                            height: 84,
                            child: Image.network(
                              'https://phimimg.com/${result.poster_url}',
                              fit: BoxFit.cover,
                            ),
                          )
                        : SizedBox.shrink(),
                    title: Text(result.name),
                    subtitle: Text(result.origin_name),
                  );
                },
              ),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }
}
