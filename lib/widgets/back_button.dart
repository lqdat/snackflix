import 'package:flutter/material.dart';

import '../colors.dart';

class BackBtn extends StatelessWidget {
  bool isCancel=false;
   BackBtn(
    this.isCancel,
    {
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      margin: const EdgeInsets.only(top: 16, left: 16),
      decoration: BoxDecoration(
          color: Colours.scaffoldBGColor,
          borderRadius: BorderRadius.circular(8)),
      child: IconButton(
        focusColor: Colors.blueGrey.shade900,
        onPressed: () {
        
          Navigator.pop(context);
        },
        icon:  Icon(!isCancel? Icons.arrow_back_rounded:Icons.keyboard_arrow_left_outlined),
      ),
    );
  }
}
