// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieproject/models/detail_movie.dart';
import 'package:movieproject/models/movies.dart';
import 'package:movieproject/widgets/back_button.dart';
import 'package:movieproject/widgets/play_video.dart';

import '../api/movieapi.dart';

class DetailMoiveScreens extends StatefulWidget {
  String movies_slug;
  DetailMoiveScreens(this.movies_slug, {super.key});
  @override
  State<DetailMoiveScreens> createState() => _DetailMoiveScreens();
}

class _DetailMoiveScreens extends State<DetailMoiveScreens> {
  late Future<DetailMovie> detailMovie;
  @override
  void initState() {
    super.initState();
    detailMovie = MovieApi().getDetailMovie(widget.movies_slug);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: detailMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('${snapshot.data!.poster_url}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            backgroundColor: Colors.transparent,
                            expandedHeight: 16,
                            pinned: true,
                            flexibleSpace: SizedBox.shrink(),
                          ),
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  // Modified poster layout
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.6,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              spreadRadius: 3,
                                              blurRadius: 7,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Image.network(
                                          '${snapshot.data!.thumb_url}',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(height: 16),
                                  Center(
                                    child: Text(
                                      '${snapshot.data!.name}',
                                      style: GoogleFonts.roboto(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Center(
                                      child: Container(
                                          
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          
                                          child: IconButton(
                                            icon: Image.asset(
                                                'assets/images/play.png',
                                                width: 50,
                                                height: 50),
                                            onPressed: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PlayVideo(
                                                    snapshot.data!.slug),
                                              ),
                                            ),

                                            // InkWell(
                                            //     highlightColor: Colors.transparent,
                                            //     onTap: () => Navigator.push(
                                            //           context,
                                            //           MaterialPageRoute(
                                            //             builder: (context) =>
                                            //                 PlayVideo(snapshot.data!.slug),
                                            //           ),
                                            //         ),
                                            //     child: Ink(
                                            //       child: Align(
                                            //         alignment: Alignment.center,
                                            //         child: Image.asset(
                                            //             'assets/images/play.png',
                                            //             width: 50,
                                            //             height: 30),
                                            //       ),
                                            //     )),
                                          ))),

                                  Text(
                                    'Nội dung',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${snapshot.data!.content}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Thời gian',
                                    style: GoogleFonts.openSans(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '${snapshot.data!.time}',
                                    style: GoogleFonts.roboto(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Năm: ',
                                        style: GoogleFonts.roboto(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${snapshot.data!.year}',
                                        style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
