import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/models/server.dart';

class VotesField extends StatelessWidget {

  final Server server;

  VotesField(this.server);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SelectableText("Votes", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
        SelectableText("${server.votecount}", style: GoogleFonts.openSans(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.lightGreenAccent),),
      ],
    );
  }

}

class PlayersField extends StatelessWidget {

  final Server server;

  PlayersField(this.server);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SelectableText("Players", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
        SelectableText("${server.players}", style: GoogleFonts.openSans(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.lightBlueAccent),),
      ],
    );
  }

}

class ScoreField extends StatelessWidget {

  final Server server;

  ScoreField(this.server);

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SelectableText("Score", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
        SelectableText("${server.score}", style: GoogleFonts.openSans(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.redAccent),),
      ],
    );
  }

}

class CapacityField extends StatelessWidget {

  final Server server;

  CapacityField(this.server);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SelectableText("Capacity", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
        SelectableText("${server.maxplayers}", style: GoogleFonts.openSans(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.yellow),),
      ],
    );
  }

}

