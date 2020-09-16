import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/models/server.dart';
import 'package:stylight/stylight.dart';

class VotesField extends StatelessWidget {

  final Server server;

  VotesField(this.server);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SelectableText("Votes", style: TextStyles.Header.style,),
        SelectableText("${server.votecount}", style: GoogleFonts.openSans(textStyle: TextStyles.Title2.style.copyWith(color: Hues.Green.hard, fontWeight: FontWeight.w900, fontSize: 30),)),
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
        SelectableText("Players",  style: TextStyles.Header.style,),
        SelectableText("${server.players}", style: GoogleFonts.openSans(textStyle: TextStyles.Title2.style.copyWith(color: Hues.Blue.hard, fontWeight: FontWeight.w900, fontSize: 30))),
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
        SelectableText("Score", style: TextStyles.Header.style,),
        SelectableText("${server.score}", style: GoogleFonts.openSans(textStyle: TextStyles.Title1.style.copyWith(color: Hues.Red.hard, fontWeight: FontWeight.w900, fontSize: 30))),
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
        SelectableText("Capacity",  style: TextStyles.Header.style,),
        SelectableText("${server.maxplayers}", style: GoogleFonts.openSans(textStyle: TextStyles.Title2.style.copyWith(color: Hues.Yellow.hard, fontWeight: FontWeight.w900, fontSize: 30))),
      ],
    );
  }

}

