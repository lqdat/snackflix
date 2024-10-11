import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movieproject/screens/list_movie_cartoon.dart';
import 'package:movieproject/screens/list_movie_new.dart';
import 'package:movieproject/screens/list_movie_series.dart';
import 'package:movieproject/screens/list_movie_single.dart';
import 'package:movieproject/screens/list_movie_tvshow.dart';
import 'package:movieproject/screens/splash.dart';
import 'colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
        child: 
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SnackFlix',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colours.scaffoldBGColor,
      ),
      home: SplashScreen(),
      routes:{
        'newMovie': (context) => ListMovieNew(),
        'singleMovie': (context) => ListMovieSingle(),
        'serieMovie': (context) => ListMovieSeries(),
        'tvShow': (context) => ListMovieTvshow(),
        'cartoonMovie': (context) => ListMovieCartoon(),
      } ,
    ));
  }
}
