import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter_cursor/flutter_cursor.dart';

class Href extends StatelessWidget {

  Widget child;
  String href;

  Href({this.child, this.href});

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        html.window.location.href = href;
      },
        child: HoverCursor(
          cursor: Cursor.pointer,
            child: child
        )
    );
  }
}
