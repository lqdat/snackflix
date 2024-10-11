// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieproject/api/api.dart';
import 'package:movieproject/api/movieapi.dart';
import 'package:movieproject/api/sapi.dart';
import 'package:movieproject/models/movie.dart';
import 'package:movieproject/models/movies.dart';
import 'package:movieproject/models/series.dart';
import 'package:movieproject/screens/menu_wiget.dart';
import 'package:movieproject/widgets/movie_slide.dart';
import '../widgets/movies_slider.dart';
import 'package:movieproject/widgets/multi_search.dart';
import '../widgets/trending_slider.dart';
import '../widgets/trending_slider_series.dart';

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topRatedMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Series>> trendingSeries;
  late Future<List<Series>> topRatedSeries;
  late Future<List<Series>> popularSeries;
  late Future<List<Movies>> newMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    topRatedMovies = Api().getTopRatedMovies();
    upcomingMovies = Api().getUpcomingMovies();
    trendingSeries = SApi().getTrendingSeries();
    topRatedSeries = SApi().getTopRatedSeries();
    popularSeries = SApi().getPopularSeries();
    newMovies = MovieApi().getNewUpdateMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromRGBO(210, 32, 60, 1).withOpacity(.5),
                const Color.fromRGBO(86, 66, 212, 1).withOpacity(.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'SnackFlix',
              style: GoogleFonts.aBeeZee(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color.fromRGBO(210, 32, 60, 1).withOpacity(.5),
                const Color.fromRGBO(86, 66, 212, 1).withOpacity(.5),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitle('Phim mới cập nhật'),
                SizedBox(
                  child: FutureBuilder(
                    future: newMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MovieSlide(snapshot: snapshot);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                SectionTitle('Phim thịnh hành'),
               
                SectionTitle('Top phim hay'),
                SizedBox(
                  child: FutureBuilder(
                    future: topRatedMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      } else if (snapshot.hasData) {
                        return MoviesSlider(snapshot: snapshot);
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                
                
                SectionTitle('Phim truyền hình thịnh hành'),
                
                SectionTitle('Top phim truyền hình'),
               
                SectionTitle('Phim truyền hình nổi tiếng'),
                
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MultiSearchScreen()),
          );
        },
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(child: MenuWiget()),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const SizedBox(
        //   height: 10,
        // ),
        Expanded(
          flex: 25,
          child: Text(
          title,
          style: GoogleFonts.aBeeZee(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ))
        
      ],
    );
  }
}
