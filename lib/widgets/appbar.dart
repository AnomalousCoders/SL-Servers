import 'package:flutter/material.dart';

class SLSAppBar extends AppBar {

  SLSAppBar() : super(
      backgroundColor: Colors.red,
      title: Text("SL Servers"),
      actions: [],
      flexibleSpace: Container(
        //Will center the widget, i don't know why but it does
        height: 1000,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [],
        ),
      )
  );

}