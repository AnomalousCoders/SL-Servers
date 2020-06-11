import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/main.dart';
import 'package:slservers/widgets/href.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 6;
    return Container(
      height: height,
      width: double.infinity,
      color: ColorConstants.background.shade700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Href(child: Text("Impressum", style: GoogleFonts.raleway(fontWeight: FontWeight.bold),), href: "/impressum.html",)
            ],
          )
        ],
      ),
    );
  }
}
