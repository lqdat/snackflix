// ignore_for_file: must_be_immutable, sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movieproject/screens/listmovie.dart';
import 'package:movieproject/widgets/back_button.dart';

class MenuWiget extends StatefulWidget {
  MenuWiget();
  @override
  _MenuWiget createState() => _MenuWiget();
}

class _MenuWiget extends State<MenuWiget> {
  @override
  Widget build(BuildContext context) {
    return 
    Scaffold(
      appBar: AppBar(
        leading: BackBtn(true),
        backgroundColor: Colors.transparent,
      ),
      body: 
    ListView(
      children: <Widget>[
        Image.asset('assets/logo.png', width: 100, height: 100),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListMovie(),
                  ),
                );
          },
          child: ListTile(
            leading: Image.asset(
              "assets/images/drama.png",
              width: 30, height: 30
            ),
            title: Text("Phim bộ",
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {
           Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListMovie(),
                  ),
                );
          },
          child: ListTile(
            leading: Image.asset("assets/images/clapperboard.png",width: 30, height: 30),
            title: Text("Phim lẻ",
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: Image.asset("assets/images/tv.png",width: 30, height: 30),
            title: Text("TV Shows",
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: Image.asset("assets/images/app.png",width: 30, height: 30),
            title: Text("Thể loại",
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: Image.asset("assets/images/country.png",width: 30, height: 30),
            title: Text("Quốc gia",
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: ListTile(
            leading: Image.asset("assets/images/calendar.png",width: 30, height: 30),
            title: Text("Năm",
                style: TextStyle(fontSize: 15, color: Colors.white)),
          ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
            shadowColor: WidgetStateProperty.all<Color>(Colors.transparent),
          ),
        ),
        SizedBox(height: 5)
      ],
    )
  );}
}
