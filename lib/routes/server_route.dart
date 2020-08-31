import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:slservers/data/servers.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/href.dart';
import 'package:slservers/widgets/instance_widget.dart';
import 'package:slservers/widgets/login_status.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/server_numerics.dart';
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

  static const String FALLBACK_BANNER = "https://i.imgur.com/ZEKwGtU.jpg";
  static const String ICON_FALLBACK = "https://i.imgur.com/eozgscT.jpg";

  Server server;

  _ServerRouteState(this.server);

  GlobalKey _scaffoldKey = GlobalKey(debugLabel: "ServerScaffold");

  @override
  Widget build(BuildContext context) {

    if (server == null) {
      print("Server not found");
    } else {
      print(server.toJson());
      print(server.iconUrl);
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
                    width: double.infinity,
                    height: 50,
                    color: ColorConstants.primary,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                            Navigator.of(context).pushReplacementNamed("/");
                          }),
                          LoginStatus()
                        ],
                      ),
                    ),
                  ),

                  /*
                  Container(
                    width: width,
                    child: Stack(
                      children: <Widget>[
                       // Image.network(server.banner??FALLBACK_BANNER, width: width, height: height / 4, fit: BoxFit.cover),
                        IconButton(icon: Icon(Icons.arrow_back), onPressed: () {
                          SLServers.router.pop(context);
                        })
                      ],
                    ),
                  ),
                  */

                  Container(height: 32,),


                 Container(
                   width: width,
                   child: Wrap(
                     alignment: WrapAlignment.center, spacing: 32, runSpacing: 32, runAlignment: WrapAlignment.spaceEvenly,
                      children: <Widget>[

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width / 5,
                              height: height / 16 * 13,
                              child: Card(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                elevation: 5,
                                child: Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // LinearGradient(colors: [Color(0xFFeb3349), Color(0xFFf45c43)]
                                              gradient: ColorConstants.primaryGradient,
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Container(height: 16,),
                                                Text("Network", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 64.0, right: 64.0, top: 32.0, bottom: 32),
                                                  child: Container(
                                                    child: Container(child: Image.network(server.iconUrl??ICON_FALLBACK, fit: BoxFit.cover,), color: ColorConstants.background[700]),
                                                    decoration: BoxDecoration(
                                                        boxShadow: [BoxShadow(offset: Offset(1, 2), color: Colors.black45, blurRadius: 3)]
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: Text(server.name, style: GoogleFonts.raleway(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white), textAlign: TextAlign.center,),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                                                  child: Text(server.preview, style: GoogleFonts.robotoCondensed(fontSize: 18,color: Colors.white, fontWeight: FontWeight.w400), textAlign: TextAlign.center),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: ColorConstants.cardGradient
                                          ),
                                          width: width / 5,
                                          child: Column(
                                            children: [
                                              Container(height: 32,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  PlayersField(server),
                                                  CapacityField(server),
                                                  VotesField(server),
                                                  ScoreField(server)
                                                ],
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
                                                }, splashColor: Colors.green, color: Colors.lightGreen),
                                              ),
                                              Container(height: 32,),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(padding: EdgeInsets.all(16),),
                            Container(
                              width: width / 4 * 2.5,
                              height: height / 16 * 13,
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  TabbedView(navigation: <Widget>[
                                    Text("Home", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                    Text("Rules", style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                                  ], widgets: [
                                        () => Container(width:  width / 4 * 2.5,child: HtmlWidget(md.markdownToHtml(server.description,extensionSet: md.ExtensionSet.commonMark, inlineOnly: false))),
                                        () {
                                      int i = 1;
                                      return Column(
                                        children: <Widget>[
                                          Container(height: 16),
                                          Text("Rules", style: GoogleFonts.raleway(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white), textAlign: TextAlign.center,),
                                          Container(
                                            width: width / 6 * 3,
                                            child: Container(
                                              width: width / 6 * 2,
                                              child: Column(children: server.rules.map((e) => Row(children: <Widget>[
                                                Text("${i++}. ", style: GoogleFonts.roboto(fontSize: 30, color: Colors.white70),),
                                                Text(e, style: GoogleFonts.raleway(fontSize: 20))
                                              ], crossAxisAlignment: CrossAxisAlignment.center,)).toList(), crossAxisAlignment: CrossAxisAlignment.center),
                                            ),
                                          ),
                                          Container(height: 16),
                                        ],
                                      );
                                    }
                                  ], width: width / 6 * 4, height:  height / 16 * 13,),
                                ],
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: width / 5 * 1.68,
                          constraints: BoxConstraints(minHeight: 250),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 5,
                            color: ColorConstants.background[600],
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: ColorConstants.cardGradient
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Servers", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: server.instanceRefs.map((e) => InstanceWidget(instance: e, sendToast: (x,y) => this.sendToast(context, x, y),)).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: width / 5 * 1.22,
                          constraints: BoxConstraints(minHeight: 250),
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: ColorConstants.cardGradient
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Tags", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                                          child: GridView.count(crossAxisCount: 3, scrollDirection: Axis.vertical,
                                            children: server.tags.map((e) => Tags.parse(e)).toList(),
                                            crossAxisSpacing: 8, mainAxisSpacing: 8, shrinkWrap: true,childAspectRatio: 3.5 / 1,),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Container(
                          width: width / 5 * 1.15,
                          constraints: BoxConstraints(minHeight: 250),
                          child: Card(
                            color: ColorConstants.background[600],
                            elevation: 5,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: ColorConstants.cardGradient
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text("Contact", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        _discordButton(),
                                        _webButton(),
                                        _emailButton(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                 ),

                  Container(height: 128,),
                ],
              ),

              /*
              Positioned(
                top: (height / 3) - 100,
                left: ((width / 5) - 200) / 2,
                  child: Image.network(server.icon??ICON_FALLBACK, width: 200, height: 200, fit: BoxFit.cover,)
              )

               */
            ],
          ),
        ),
      ),
    );
  }

  Widget _discordButton() {
    return SyncSwitchWidget(
      boolean: server.discord != null,
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
            ), text: Text("Discord", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 20),), width: 250, height: 40,),
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
      child: GestureDetector(
          onTap: () {
            sendToast(context, "Copied E-Mail to Clipboard", Colors.blue);
            Clipboard.setData(ClipboardData(text: server.mail));
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Tooltip(message: server.mail,
                child: ShieldButton(color: Color(0xFFD83B3B), icon: Icon(Icons.email, size: 30,), text: Text("E-Mail", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 20),), width: 250, height: 40,)
            ),
          )
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