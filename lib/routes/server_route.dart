import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cursor/flutter_cursor.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:slservers/data/servers.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/href.dart';
import 'package:slservers/widgets/instance_widget.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/shield_button.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';
import 'package:slservers/widgets/tabbed_view.dart';
import 'package:slservers/widgets/tags.dart';

class ServerRoute extends StatefulWidget {
  ServerRoute({Key key, this.server}) : super(key: key);

  Server server;

  @override
  _ServerRouteState createState() => _ServerRouteState(server);
}

class _ServerRouteState extends State<ServerRoute> {

  static const String FALLBACK_BANNER = "https://pbs.twimg.com/media/DwfiV_fX4AAP1nf.jpg";
  static const String ICON_FALLBACK = "https://www.fad-multigaming.de/img/bf4__server_performance_icons/server_performance_warning.jpg";

  Server server;

  _ServerRouteState(this.server);

  GlobalKey _scaffoldKey = GlobalKey(debugLabel: "ServerScaffold");

  @override
  Widget build(BuildContext context) {

    if (server == null) {
      print("Server not found");
    }

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      body: AuthManager(
        ignoreLogin: true,
        child: (_) => ScrollWrapper(
          wrapScreenSize: false,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: width, height: height / 3,
                    child: Stack(
                      children: <Widget>[
                        Image.network(server.banner??FALLBACK_BANNER, width: width, height: height / 3, fit: BoxFit.fitWidth),
                        IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                          SLServers.router.pop(context);
                        })
                      ],
                    ),
                  ),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: height),
                        child: Container(
                          width: width / 5, color: ColorConstants.background.shade600,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(height: 116),
                              Text(server.name, style: GoogleFonts.raleway(fontSize: 35, fontWeight: FontWeight.w800, color: Colors.white), textAlign: TextAlign.center,),
                              Text(server.preview, style: GoogleFonts.roboto(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
                              Container(height: 16,),
                              Container(
                                width: 120,
                                height: 60,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Votes", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                                    Text("${server.votecount}", style: GoogleFonts.raleway(fontWeight: FontWeight.w800, fontSize: 30, color: Colors.lightGreenAccent),),
                                  ],
                                ),
                              ),
                              Container(
                                width: 120,
                                child: RaisedButton(child: Text("Vote", style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.w600),), onPressed: () async {
                                  bool success = await Servers.vote(server.id);
                                  if (success) {
                                    sendToast(context, "Your vote has been registered!", Colors.green);
                                  } else {
                                    sendToast(context, "You already voted for this server", Colors.redAccent);
                                  }
                                }, color: Colors.green),
                              ),
                              Container(height: 16,),
                              Text("Servers", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: server.instanceRefs.map((e) => InstanceWidget(instance: e, sendToast: (x,y) => this.sendToast(context, x, y),)).toList(),
                                ),
                              ),
                              Container(height: 16,),
                              Text("Tags", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                                child: GridView.count(crossAxisCount: 3, scrollDirection: Axis.vertical,
                                  children: server.tags.map((e) => Tags.parse(e)).toList(),
                                  crossAxisSpacing: 8, mainAxisSpacing: 8, shrinkWrap: true,childAspectRatio: 3.5 / 1,),
                              ),
                              Container(height: 16,),
                              Text("Contact", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                              _discordButton(),
                              _webButton(),
                              _emailButton(),
                              Container(height: 16,)
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TabbedView(navigation: <Widget>[
                            Text("Home"),
                            Text("Rules"),
                          ], widgets: [
                                () => Container(
                                  width: width / 5 * 4,
                                  //height: height - 60,
                                  child: HtmlWidget(
                                    md.markdownToHtml(server.description,extensionSet: md.ExtensionSet.commonMark, inlineOnly: false),
                                  ),
                                ),
                                () {
                                  int i = 1;
                                  return Column(
                                    children: <Widget>[
                                      Container(height: 16),
                                      Text("Rules", style: GoogleFonts.raleway(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
                                      Container(
                                        width: width / 5 * 3,
                                        child: Column(children: server.rules.map((e) => Row(children: <Widget>[
                                          Text("${i++}. ", style: GoogleFonts.roboto(fontSize: 30, color: Colors.white70),),
                                          Text(e, style: GoogleFonts.raleway(fontSize: 20),)
                                        ], crossAxisAlignment: CrossAxisAlignment.center,)).toList(), crossAxisAlignment: CrossAxisAlignment.start),
                                      ),
                                    ],
                                  );
                                }
                          ], width: width / 5 * 4, height: height,),
                        ],
                      )
                    ],
                  )
                ],
              ),
              Positioned(
                top: (height / 3) - 100,
                left: ((width / 5) - 200) / 2,
                  child: Image.network(server.icon??ICON_FALLBACK, width: 200, height: 200, fit: BoxFit.cover,)
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _discordButton() {
    return SyncSwitchWidget(
      boolean: server.discord != null && server.description != "",
      negative: Container(),
      positive: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Tooltip(
          message: server.discord??"",
          child: Href(
            href: server.discord??"",
            child: ShieldButton(color: Color(0xFF7289DA), icon: Padding(
              padding: const EdgeInsets.only(left:6, top: 6),
              child: Image.network("https://discord.com/assets/28174a34e77bb5e5310ced9f95cb480b.png"),
            ), text: Text("DISCORD", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 20),), width: 250, height: 40,),
          ),
        ),
      ),
    );
  }

  Widget _emailButton() {
    if (server.mail == null || server.mail == "") return Container();

    List<String> mailSpit = server.mail.split("@");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: HoverCursor(
        cursor: Cursor.copy,
        child: GestureDetector(
            onTap: () {
              sendToast(context, "Copied E-Mail to Clipboard", Colors.blue);
              Clipboard.setData(ClipboardData(text: server.mail));
            },
            child: ShieldButton(color: Color(0xFFD83B3B), icon: Icon(Icons.email, size: 30,), text: Text("${mailSpit[0]}\n@${mailSpit[1]}", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 15),), width: 250, height: 40,)
        ),
      ),
    );
  }

  Widget _webButton() {

    if (server.website == null || server.website == "") return Container();

    String s = server.website
        .replaceFirst("https://", "")
        .replaceFirst("http://", "");
    List<String> spliced = s.split("/");

    return SyncSwitchWidget(
      boolean: server.website != null,
      negative: Container(),
      positive: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Tooltip(
          message: server.website,
          child: Href(
            href: server.website,
              child: ShieldButton(color: Colors.orange, icon: Icon(Icons.language, size: 30,), text: Text(spliced[0],
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 15),), width: 250, height: 40,)
          ),
        ),
      ),
    );
  }

  void sendToast(BuildContext context, String msg, Color color) {
    final SnackBar snack = SnackBar(content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(msg, style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,),
    ), backgroundColor: color,);
    (_scaffoldKey.currentState as ScaffoldState).showSnackBar(snack);
  }

}