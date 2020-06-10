import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/widgets/tags.dart';

class ServerWidget extends StatefulWidget {

  Server server;

  ServerWidget(this.server);

  @override
  _ServerWidgetState createState() => _ServerWidgetState(server);
}

class _ServerWidgetState extends State<ServerWidget>
    with SingleTickerProviderStateMixin {

  static const String ICON_FALLBACK = "https://www.fad-multigaming.de/img/bf4__server_performance_icons/server_performance_warning.jpg";

  Server server;

  AnimationController _controller;

  _ServerWidgetState(this.server);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 1200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.network(server.icon??ICON_FALLBACK, width: 200, height: 200, fit: BoxFit.cover,),
              server.promoted ? Positioned(child: Icon(Icons.verified_user, size: 40,), bottom: 8, right: 8,) : Container()
            ],
          ),
          Container(width: 8,),
          Stack(
            children: <Widget>[
              Positioned(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 8,),
                      Text(server.name, style: GoogleFonts.raleway(fontSize: 30, fontWeight: FontWeight.w800, color: Colors.white),),
                      Container(
                        width: 600,
                          child: Text(server.preview, style: GoogleFonts.roboto(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white70), softWrap: true,)
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 8,
                  left: 0,
                  child: Container(
                    height: 60,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 120,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text("Votes", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                                Text("${server.votecount}", style: GoogleFonts.raleway(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.lightGreenAccent),),
                              ],
                            ),
                          ),
                          GridView.count(crossAxisCount: 2, scrollDirection: Axis.horizontal,
                            children: server.tags.map((e) => Tags.parse(e)).toList(),
                            crossAxisSpacing: 8, mainAxisSpacing: 8, shrinkWrap: true,childAspectRatio: 1 / 3.5,),
                        ],
                      )
                  ),
              ),
            ],
          ),
          Container(
            height: double.infinity,
            alignment: Alignment.topRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: server.languages.map((e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(height: 50, width: 100,color: Colors.white,),
              )).toList(),
            ),
          )
        ],
      ),
    );
  }
}
