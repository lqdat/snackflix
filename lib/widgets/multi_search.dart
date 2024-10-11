import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movieproject/screens/details_screens.dart'; // Import the DetailScreen
import 'package:movieproject/screens/details_screens_series.dart';

import '../models/movie.dart';
import '../models/series.dart'; // Import the SeriesDetailScreen

class MultiSearchScreen extends StatefulWidget {
  @override
  _MultiSearchScreenState createState() => _MultiSearchScreenState();
}

class _MultiSearchScreenState extends State<MultiSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> searchResults = [];

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) return;

    final String apiUrl =
        'https://api.themoviedb.org/3/search/multi?include_adult=true&language=en-US&page=1&query=$query';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDgyOWNlZTljODIyMThjYzJkNGM5NWE0ZWY3ZDk5NCIsInN1YiI6IjY0ZDUzMmMxZjQ5NWVlMDI5NDJlOTNjYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.UBSLjlMq4g3Wspt80tI8BhX67R8BbFa2gRCCSc0nD_0',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['results'];
      });
    } else {
      throw Exception('Failed to load search results');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _performSearch(_searchController.text);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: searchResults.length,
                itemBuilder: (context, index) {
                  final result = searchResults[index];
                  return ListTile(
                    onTap: () {
                      // Navigate to the appropriate detail screen
                      if (result['media_type'] == 'movie') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(movie: Movie.fromJson(result)),
                          ),
                        );
                      } else if (result['media_type'] == 'tv') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SeriesDetailScreen(
                                series: Series.fromJson(result)),
                          ),
                        );
                      }
                    },
                    leading: result['poster_path'] != null
                        ? Container(
                            width: 56,
                            height: 84,
                            child: Image.network(
                              'https://image.tmdb.org/t/p/w92${result['poster_path']}',
                              fit: BoxFit.cover,
                            ),
                          )
                        : SizedBox.shrink(),
                    title: Text(result['name'] ?? result['title'] ?? 'N/A'),
                    subtitle: Text(result['overview'] ?? 'N/A'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
