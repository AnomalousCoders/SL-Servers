import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server_instance.dart';

class ServerPlugins extends StatelessWidget {

  ServerInstance instance;


  ServerPlugins(this.instance);

  @override
  Widget build(BuildContext context) {
    print(instance.plugins.join(" "));
    return Column(
      children: <Widget>[
        Text(instance.name, style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.bold),),
        Container(
            color: ColorConstants.background.shade600,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(instance.plugins.join(" ").breakAfter(60), style: GoogleFonts.roboto()),
            )
        )
      ],
    );
  }
}

extension LineBreaker on String {

  String breakAfter(double length) {
    List<String> lines = List();
    List<String> words = split(" ");
    var buffer = "";

    for (var value in words) {
      if (buffer.length == 0) {
        buffer = value;
      }
      else if (buffer.length + value.length + 1 <= length) {
        buffer = buffer + " "+ value;
      }
      else {
        lines.add(buffer);
        buffer = value;
      }
    }

    lines.add(buffer);
    return lines.join("\n");
  }

}