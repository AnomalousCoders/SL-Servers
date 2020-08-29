import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Href extends StatelessWidget {

  Widget child;
  String href;

  Href({this.child, this.href});

  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        js.context.callMethod("open", [href]);
      },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: child,
        )
    );
  }
}
