import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieproject/screens/detail_moive_screens.dart';

class MovieSlide extends StatelessWidget {
  const MovieSlide({
    super.key,
    required this.snapshot,
     required this.isImage,
     required this.route,
  });
  final AsyncSnapshot snapshot;
  final bool isImage;
  final String route;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length + 1,
        itemBuilder: (context, index) {
          return (index != snapshot.data!.length)
              ? InkWell(
                  focusColor: Colors.blueGrey.shade300,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => 
                        
                        DetailMoiveScreens(
                          
                          snapshot
                              .data![index].slug, // Removed 'const' from here
                        ),
                      ),
                    );
                  },
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 200,
                            width: 150,
                            child: Image.network(
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                              isImage ?'${snapshot.data![index].poster_url}' :'https://phimimg.com/${snapshot.data![index].poster_url}',
                            ),
                          ))))
              : InkWell(
                  focusColor: Colors.blueGrey.shade300,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '$route'
                    );
                  },
                  child: Padding(
                      padding: EdgeInsets.all(8),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            color: Colors.grey.shade700,
                            child: SizedBox(
                                height: 200,
                                width: 150,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Xem thêm..',
                                    style: GoogleFonts.openSans(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),
                          ))));
        },
      ),
    );
  }
}
