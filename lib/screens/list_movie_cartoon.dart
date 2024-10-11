import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieproject/api/movieapi.dart';
import 'package:movieproject/models/single_movie.dart';
import 'package:movieproject/screens/detail_moive_screens.dart';

class ListMovieCartoon extends StatefulWidget {
  const ListMovieCartoon({super.key});

  @override
  _ListMovieCartoonState createState() => _ListMovieCartoonState();
}

class _ListMovieCartoonState extends State<ListMovieCartoon> {
  late List<SingleMovie> listMovies = [];
  late int page = 1;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getList(page);
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
                'Hoạt hình',
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
        body: !isLoading
            ? SafeArea(
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
                  child: Column(
                    children: [
                      Expanded(
                          flex: 1,
                          child: GridView.count(
                              crossAxisCount: 5, // decides number of columns
                              padding: const EdgeInsets.all(5),
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              children:
                                  List.generate(listMovies.length, (index) {
                                return InkWell(
                                  autofocus: true,
                                  focusColor: Colors.blueGrey.shade300,
                                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailMoiveScreens(
                                             
                                          listMovies[index]
                                              .slug, // Removed 'const' from here
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            filterQuality: FilterQuality.medium,
                                            fit: BoxFit.fill,
                                            width: 150,
                                            height: 190,
                                            'https://phimimg.com/${listMovies[index].poster_url}',
                                          ),
                                        ),
                                      ),

                                      // SizedBox(height: 7,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(listMovies[index].name),
                                      )
                                    ],
                                  ),
                                );
                              }))),
                      Row(
                        children: [
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomLeft,
                            child: TextButton(
                              onPressed: () {
                                if (page > 1) {
                                  setState(() {
                                    page = page - 1;
                                  });
                                  getNewList(page);
                                }
                              },
                              child: const Text('Trang trước'),
                            ),
                          )),
                          Expanded(
                              flex: 4,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Trang $page',
                                  style: GoogleFonts.openSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  page = page + 1;
                                });
                                getNewList(page);
                              },
                              child: const Text('Trang tiếp theo'),
                            ),
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  Future<List<SingleMovie>> getList(int page) async {
    setState(() {
      isLoading=true;
    });
     await MovieApi().getCarToonMovies(page).then((value)=>
    setState(() {
      listMovies = value;
      isLoading=false;
    })
    );
    
    return listMovies;
  }

  Future<List<SingleMovie>> getNewList(int page) async {
    setState(() {
      isLoading=true;
    });
     await MovieApi().getCarToonMovies(page).then((value)=>
    setState(() {
      listMovies = value;
      isLoading=false;
    })
    );
    
    return listMovies;
  }
}
