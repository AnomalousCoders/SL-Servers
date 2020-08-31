import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';

class Tags {

  static const TagWidget NSWF = TagWidget("NSFW", Colors.red, tooltip: "This server appeals to mature audience",);
  static const TagWidget MODDED = TagWidget("MODDED", Colors.blue, tooltip: "This server uses a server side modded version of the game",);
  static const TagWidget ROLEPLAY = TagWidget("ROLEPLAY", Colors.deepOrange, tooltip: "This server requires roleplay",);
  static const TagWidget EVENTS = TagWidget("EVENTS", Color(0xFFFF9505), tooltip: "This server regularly does events",);
  static const TagWidget P2W =  TagWidget("P2W", Colors.green, tooltip: "This server sells in-game advantages for real money");
  static const TagWidget ANIME = TagWidget("ANIME", Colors.purpleAccent, tooltip: "This server encourages the anime sub-culture",);
  static const TagWidget ANARCHY = TagWidget("ANARCHY", Colors.black, tooltip: "This server doesn't enforce or have rules",);
  static const TagWidget TEENS = TagWidget("TEENS+", Colors.redAccent, tooltip: "This server has minimum age and is targeting teens and adults",);
  static const TagWidget BEGINNERS = TagWidget("BEGINNERS", Colors.teal, tooltip: "This server is beginner friendly",);
  static const TagWidget MODERATED = TagWidget("MODERATED", Colors.indigo, size: 13, tooltip: "This server is actively moderated and rules are enforced",);
  static const TagWidget VOTEREWARD = TagWidget("VOTE REWARD", Colors.deepPurple, size: 12, tooltip: "This server offers vote rewards",);

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
  final String tooltip;

  const TagWidget(this.text, this.color, {this.size = 15, this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: SyncSwitchWidget(
        boolean: tooltip != null,
        positive: Tooltip(
          message: tooltip??"",
            child: SelectableText(text, style: GoogleFonts.raleway(color: Colors.white, fontSize: size, fontWeight: FontWeight.w800),)
        ),
        negative: SelectableText(text, style: GoogleFonts.raleway(color: Colors.white, fontSize: size, fontWeight: FontWeight.w800),),
      ),
    );
  }


}