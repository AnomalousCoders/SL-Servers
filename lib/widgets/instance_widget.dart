import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/instance.dart';

class InstanceWidget extends StatefulWidget {
  InstanceWidget({Key key, this.instance}) : super(key: key);

  ServerInstance instance;

  @override
  _InstanceWidgetState createState() => _InstanceWidgetState(instance);
}

class _InstanceWidgetState extends State<InstanceWidget> {

  ServerInstance instance;

  _InstanceWidgetState(this.instance);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background.shade500,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: Text(instance.name, style: GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
            ),
            Container(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Server IP", style: GoogleFonts.raleway(color: Colors.white70, fontWeight: FontWeight.bold),),
                    Text(instance.address, style: GoogleFonts.roboto(fontSize: 20),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Players", style: GoogleFonts.raleway(color: Colors.white70, fontWeight: FontWeight.bold),),
                      Text("${instance.players}/${instance.maxplayers}", style: GoogleFonts.roboto(fontSize: 20, color: instance.maxplayers - instance.players == 0 ? Colors.redAccent : Colors.white)),
                    ],
                  ),
                ),
              ],
            ),
            Container(height: 16,),
            Text("Description", style: GoogleFonts.raleway(color: Colors.white70, fontWeight: FontWeight.bold),),
            Text(instance.description, style: GoogleFonts.roboto(fontSize: 20),),
            Container(height: 16,),
            Divider(),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Version", style: GoogleFonts.raleway(color: Colors.white38, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                          Container(height: 4,),
                          Text(instance.version, style: GoogleFonts.roboto(fontSize: 15, color: Colors.white70),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("NW Verified", style: GoogleFonts.raleway(color: Colors.white38, fontWeight: FontWeight.bold),textAlign: TextAlign.start),
                          Icon(instance.verified ? Icons.check : Icons.clear, color: Colors.white70,)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("FriendlyFire", style: GoogleFonts.raleway(color: Colors.white38, fontWeight: FontWeight.bold),textAlign: TextAlign.start),
                          Icon(instance.ff ? Icons.check : Icons.clear, color: Colors.white70)
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Plugins", style: GoogleFonts.raleway(color: Colors.white38, fontWeight: FontWeight.bold),textAlign: TextAlign.start),
                        Text(instance.plugins.join(" "), style: GoogleFonts.roboto(fontSize: 15, color: Colors.white70),),
                      ],
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}