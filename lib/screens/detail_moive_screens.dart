// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:movieproject/models/detail_movie.dart';
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
  List<ServerData>? listLink;

  @override
  void initState() {
    super.initState();
    detailMovie = MovieApi().getDetailMovie(widget.movies_slug);
    getLinks();
  }

  Future<void> getLinks() async {
    List<ServerData> rs = await MovieApi().getLinkMovie(widget.movies_slug);

    setState(() {
      listLink = rs;
    });

    if (rs[0].link_m3u8.isEmpty) {
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Không thể tải phim '),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Phim chưa có nguồn ! '),
                Text('Vui lòng đợi khi có cập nhật mới !'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Quay lại'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: detailMovie,
            builder: (context, snapshot) {
              if (snapshot.hasData && listLink != null) {
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
                                            MediaQuery.of(context).size.width >
                                                    360
                                                ? MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5
                                                : MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                        height: MediaQuery.of(context)
                                                    .size
                                                    .height >
                                                640
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.6
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.25,
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
                                        margin: const EdgeInsets.only(top: 12),
                                        child: IconButton(
                                          icon: Image.asset(
                                              'assets/images/play.png',
                                              width: 50,
                                              height: 50),
                                          onPressed: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PlayVideo(
                                                  snapshot.data!.slug, "", 0),
                                            ),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  (listLink!.length > 1 &&
                                          snapshot.data!.type != "single")
                                      ? SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: listLink?.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: Container(
                                                    color: Colors.grey.shade900,
                                                    child: InkWell(
                                                        focusColor: Colors
                                                            .grey.shade300,
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) => PlayVideo(
                                                                    snapshot
                                                                        .data!
                                                                        .slug,
                                                                    listLink![
                                                                            index]
                                                                        .link_m3u8,
                                                                    index),
                                                              ));
                                                        },
                                                        child: Ink(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text((index +
                                                                    1)
                                                                .toString()))),
                                                  ),
                                                );
                                              }))
                                      : SizedBox(),
                                  SizedBox(
                                    height: 8,
                                  ),
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
                return Center(
                  child: JumpingDots(
                      color: Colors.yellow,
                      radius: 10,
                      numberOfDots: 3,
                      animationDuration: Duration(milliseconds: 200)),
                );
              }
            }));
  }
}
