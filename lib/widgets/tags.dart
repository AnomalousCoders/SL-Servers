import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/main.dart';

class Tags {

  static const TagWidget NSWF = TagWidget("NSFW", Colors.red);
  static const TagWidget MODDED = TagWidget("MODDED", Colors.blue);
  static const TagWidget ROLEPLAY = TagWidget("ROLEPLAY", Colors.deepOrange);
  static const TagWidget EVENTS = TagWidget("EVENTS", Color(0xFFFF9505));
  static const TagWidget P2W =  TagWidget("P2W", Colors.green);
  static const TagWidget ANIME = TagWidget("ANIME", Colors.purpleAccent);
  static const TagWidget ANARCHY = TagWidget("ANARCHY", Colors.black);
  static const TagWidget TEENS = TagWidget("TEENS+", Colors.redAccent);
  static const TagWidget BEGINNERS = TagWidget("BEGINNERS", Colors.brown);
  static const TagWidget MODERATED = TagWidget("MODERATED", Colors.indigo, size: 13);
  static const TagWidget VOTEREWARD = TagWidget("VOTE REWARD", Colors.deepPurple, size: 12,);

  static TagWidget parse(String tag) {
    switch(tag.toUpperCase()) {
      case "NSWF":
        return NSWF;
      case "MODDED":
        return MODDED;
      case "ROLEPLAY":
        return ROLEPLAY;
      case "EVENTS":
        return EVENTS;
      case "P2W":
        return P2W;
      case "ANIME":
        return ANIME;
      case "ANARCHY":
        return ANARCHY;
      case "TEENS":
        return TEENS;
      case "BEGINNERS":
        return BEGINNERS;
      case "MODERATED":
        return MODERATED;
      case "VOTEREWARD":
        return VOTEREWARD;

      default: {
        if (tag.contains("#")) {
          List<String> arr = tag.split("#");
          return TagWidget(arr[0], fromHex(arr[1]));
        } else {
          return TagWidget(tag, Colors.blueGrey);
        }
      }
    }
  }

  static Color fromHex(String hexString) {
    try {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      return Color(int.parse(buffer.toString(), radix: 16));
    } catch(_) {
      return Colors.blueGrey;
    }
  }

}

class TagWidget extends StatelessWidget {

  final String text;
  final Color color;
  final double size;

  const TagWidget(this.text, this.color, {this.size = 15});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Text(text, style: GoogleFonts.raleway(color: Colors.white, fontSize: size, fontWeight: FontWeight.w800),),
    );
  }


}