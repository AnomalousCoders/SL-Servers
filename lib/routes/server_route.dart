import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/widgets/href.dart';
import 'package:slservers/widgets/instance_widget.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/shield_button.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: AuthManager(
        ignoreLogin: true,
        child: ScrollWrapper(
          wrapScreenSize: false,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(server.banner??FALLBACK_BANNER, width: width, height: height / 3, fit: BoxFit.fitWidth),
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
                              Text(server.description, style: GoogleFonts.roboto(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
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
                              Container(height: 8,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: server.instanceRefs.map((e) => InstanceWidget(instance: e)).toList(),
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
                              _emailButton()
                            ],
                          ),
                        ),
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
      boolean: server.discord != null,
      negative: Container(),
      positive: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Tooltip(
          message: server.discord,
          child: Href(
            href: server.discord,
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
    List<String> mailSpit = server.mail.split("@");
    return SyncSwitchWidget(
      boolean: server.mail != null,
      negative: Container(),
      positive: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Href(
          href: "mailto:${server.mail}",
            child: ShieldButton(color: Color(0xFFD83B3B), icon: Icon(Icons.email, size: 30,), text: Text("${mailSpit[0]}\n@${mailSpit[1]}", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 15),), width: 250, height: 40,)
        ),
      ),
    );
  }

  Widget _webButton() {

    String s = server.website
        .replaceFirst("https://", "")
        .replaceFirst("http://", "");
    List<String> splitted = s.split("/");

    return SyncSwitchWidget(
      boolean: server.website != null,
      negative: Container(),
      positive: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Tooltip(
          message: server.website,
          child: Href(
            href: server.website,
              child: ShieldButton(color: Colors.orange, icon: Icon(Icons.language, size: 30,), text: Text(splitted[0],
                style: GoogleFonts.raleway(fontWeight: FontWeight.bold, fontSize: 15),), width: 250, height: 40,)
          ),
        ),
      ),
    );
  }

}