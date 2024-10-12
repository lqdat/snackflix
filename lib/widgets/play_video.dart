import 'dart:convert';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:movieproject/api/movieapi.dart';
import 'package:movieproject/colors.dart';
import 'package:movieproject/models/detail_movie.dart';
import 'package:movieproject/screens/detail_moive_screens.dart';
import 'package:movieproject/widgets/back_button.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  String Slug;
  String link;
  int episode;
  PlayVideo(this.Slug, this.link, this.episode, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _PlayVideoState();
  }
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  int? bufferDelay;
  List<ServerData>? ListLinks;
  bool hasMovie = false;
  @override
  void initState() {
    super.initState();
    getLink();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> getLink() async {
    List<ServerData> rs = await MovieApi().getLinkMovie(widget.Slug);

    setState(() {
      ListLinks = rs;
    });
//     if(rs[0].link_m3u8.isEmpty){
// _showMyDialog();
//     }else{

    await initializePlayer(widget.episode);
//     }
  }

  Future<void> initializePlayer(int episode) async {
    _videoPlayerController1 =
        VideoPlayerController.network(ListLinks![episode].link_m3u8);

    await Future.wait([_videoPlayerController1.initialize()]);

    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    // final subtitles = [
    //     Subtitle(
    //       index: 0,
    //       start: Duration.zero,
    //       end: const Duration(seconds: 10),
    //       text: 'Hello from subtitles',
    //     ),
    //     Subtitle(
    //       index: 0,
    //       start: const Duration(seconds: 10),
    //       end: const Duration(seconds: 20),
    //       text: 'Whats up? :)',
    //     ),
    //   ];

    // final subtitles = [
    //   Subtitle(
    //     index: 0,
    //     start: Duration.zero,
    //     end: const Duration(seconds: 10),
    //     text: const TextSpan(
    //       children: [
    //         TextSpan(
    //           text: 'Hello',
    //           style: TextStyle(color: Colors.red, fontSize: 22),
    //         ),
    //         TextSpan(
    //           text: ' from ',
    //           style: TextStyle(color: Colors.green, fontSize: 20),
    //         ),
    //         TextSpan(
    //           text: 'subtitles',
    //           style: TextStyle(color: Colors.blue, fontSize: 18),
    //         )
    //       ],
    //     ),
    //   ),
    //   Subtitle(
    //     index: 0,
    //     start: const Duration(seconds: 10),
    //     end: const Duration(seconds: 20),
    //     text: 'Whats up? :)',
    //     // text: const TextSpan(
    //     //   text: 'Whats up? :)',
    //     //   style: TextStyle(color: Colors.amber, fontSize: 22, fontStyle: FontStyle.italic),
    //     // ),
    //   ),
    // ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      allowPlaybackSpeedChanging: false,
      autoPlay: true,
      fullScreenByDefault: false,
      allowFullScreen: true,
      showControls: true,
      aspectRatio: 16 / 9,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,

      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
      // additionalOptions: (context) {
      //   return <OptionItem>[
      //     OptionItem(
      //       onTap: toggleVideo,
      //       iconData: Icons.live_tv_sharp,
      //       title: 'Tập tiếp',
      //     ),
      //   ];
      // },
      // subtitle: Subtitles(subtitles),
      // subtitleBuilder: (context, dynamic subtitle) => Container(
      //   padding: const EdgeInsets.all(10.0),
      //   child: subtitle is InlineSpan
      //       ? RichText(
      //           text: subtitle,
      //         )
      //       : Text(
      //           subtitle.toString(),
      //           style: const TextStyle(color: Colors.black),
      //         ),
      // ),

      hideControlsTimer: const Duration(seconds: 5),
    );
  }

  int currPlayIndex = 0;

  // Future<void> toggleVideo() async {
  //   await _videoPlayerController1.pause();
  //   currPlayIndex += 1;
  //   if (currPlayIndex >= srcs.length) {
  //     currPlayIndex = 0;
  //   }
  //   await initializePlayer();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 400,
        leading: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(top: 16, left: 16),
              decoration: BoxDecoration(
                  color: Colours.scaffoldBGColor,
                  borderRadius: BorderRadius.circular(8)),
              child: IconButton(
                focusColor: Colors.blueGrey.shade900,
                onPressed: () {
                  _videoPlayerController1.dispose();
                  _chewieController?.dispose();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailMoiveScreens(
                        widget.Slug, // Removed 'const' from here
                      ),
                    ),
                  );
                  ;
                },
                icon: Icon(Icons.arrow_back_rounded),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 14),
              child: ListLinks != null
                  ? Text('${ListLinks![widget.episode].name}')
                  : Text(''),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 12,
            child: Center(
              child: _chewieController != null &&
                      _chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: _chewieController!,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        JumpingDots(
                            color: Colors.yellow,
                            radius: 10,
                            numberOfDots: 3,
                            animationDuration: Duration(milliseconds: 200)),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  (ListLinks != null &&
                          ListLinks!.length > 1 &&
                          ListLinks!.length > widget.episode + 1)
                      ? TextButton.icon(
                          iconAlignment: IconAlignment.end,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayVideo(
                                      widget.Slug, "", widget.episode + 1),
                                ));
                          },
                          label: const Text('Tập tiếp theo'),
                          icon: Icon(Icons.skip_next),
                        )
                      : SizedBox(),
                  TextButton.icon(
                    iconAlignment: IconAlignment.end,
                    onPressed: () {
                      _chewieController?.enterFullScreen();
                    },
                    label: const Text('Phóng to'),
                    icon: Icon(Icons.zoom_out_map),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
