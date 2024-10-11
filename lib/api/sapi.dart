import 'package:movieproject/constant.dart';
import 'dart:convert';
import 'package:movieproject/models/series.dart'; // Assuming you have a 'Series' model
import 'package:http/http.dart' as http;

class SApi {
  static const _trendingSeriesUrl =
      'https://api.themoviedb.org/3/trending/tv/day?api_key=${Constants.apikey}';

  static const _topRatedSeriesUrl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=${Constants.apikey}';

  static const _popularSeriesUrl =
      'https://api.themoviedb.org/3/tv/popular?api_key=${Constants.apikey}';

  Future<List<Series>> getTrendingSeries() async {
    final response = await http.get(Uri.parse(_trendingSeriesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((series) => Series.fromJson(series)).toList();
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<List<Series>> getTopRatedSeries() async {
    final response = await http.get(Uri.parse(_topRatedSeriesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((series) => Series.fromJson(series)).toList();
    } else {
      throw Exception('Something went wrong');
    }
  }

  Future<List<Series>> getPopularSeries() async {
    final response = await http.get(Uri.parse(_popularSeriesUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['results'] as List;
      return decodedData.map((series) => Series.fromJson(series)).toList();
    } else {
      throw Exception('Something went wrong');
    }
  }
}
