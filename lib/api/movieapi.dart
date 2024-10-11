
import 'package:movieproject/models/detail_movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieproject/models/movies.dart';
import 'package:movieproject/models/single_movie.dart';

class MovieApi {

  static const _newUpdateURL =
      'https://phimapi.com/danh-sach/phim-moi-cap-nhat?page=';
      static const _singleMovieURL =
      'https://phimapi.com/v1/api/danh-sach/phim-le?page=';
            static const _seriesMovieURL =
      'https://phimapi.com/v1/api/danh-sach/phim-bo?page=';
      static const _tvShowMovieURL =
      'https://phimapi.com/v1/api/danh-sach/tv-shows?page=';
      static const _cartoonMovieURL =
      'https://phimapi.com/v1/api/danh-sach/hoat-hinh?page=';

  static const _detailUrl =
      'https://phimapi.com/phim/';

  Future<List<Movies>> getNewUpdateMovies(int page) async {
    final response = await http.get(Uri.parse('$_newUpdateURL$page'));
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
    Future<List<SingleMovie>> getSeriesMovies(int page ) async {
    final response = await http.get(Uri.parse('$_seriesMovieURL$page'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['data']['items'] as List;
      return decodedData.map((movie) => SingleMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu');
    }
  }
  Future<List<SingleMovie>> getTvShowMovies(int page ) async {
    final response = await http.get(Uri.parse('$_tvShowMovieURL$page'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['data']['items'] as List;
      return decodedData.map((movie) => SingleMovie.fromJson(movie)).toList();
    } else {
      throw Exception('Không thể lấy dữ liệu');
    }
  }
  Future<List<SingleMovie>> getCarToonMovies(int page ) async {
    final response = await http.get(Uri.parse('$_cartoonMovieURL$page'));
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
  Future<List<ServerData>> getLinkMovie(String slug) async {
    final response = await http.get(Uri.parse('$_detailUrl$slug'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body)['episodes'][0]['server_data'] as List;
      
      var rs=decodedData.map((movie) => ServerData.fromJson(movie)).toList();
      
      return  rs;
    } else {
      throw Exception('Không thể lấy dữ liệu');
    }
  }

}
