
import 'dart:developer';

import 'package:movieproject/models/detail_movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieproject/models/movies.dart';
import 'package:movieproject/models/single_movie.dart';

class MovieApi {

  static const _newUpdateURL =
      'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=1';
      static const _singleMovieURL =
      'https://phimapi.com/v1/api/danh-sach/phim-le?page=';
  static const _detailUrl =
      'https://phimapi.com/phim/';

  Future<List<Movies>> getNewUpdateMovies() async {
    final response = await http.get(Uri.parse(_newUpdateURL));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['items'] as List;
      return decodedData.map((movie) => Movies.fromJson(movie)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu');
    }
  }
  Future<List<SingleMovie>> getSingleMovies(int page ) async {
    final response = await http.get(Uri.parse('$_singleMovieURL$page'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['data']['items'] as List;
      return decodedData.map((movie) => SingleMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu');
    }
  }
  Future<DetailMovie> getDetailMovie(String slug) async {
    final response = await http.get(Uri.parse('$_detailUrl$slug'));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body)['movie'];
      return  DetailMovie.fromJson(decodedData);
    } else {
      throw Exception('Không thể lấy dữ liệu');
    }
  }
  Future<ServerData> getLinkMovie(String slug) async {
    final response = await http.get(Uri.parse('$_detailUrl$slug'));
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedData = json.decode(response.body)['episodes'][0]['server_data'][0];
      
      var rs=ServerData.fromJson(decodedData);
      
      return  rs;
    } else {
      throw Exception('Không thể lấy dữ liệu');
    }
  }

}
