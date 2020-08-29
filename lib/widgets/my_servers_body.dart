import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/data/imgcolors.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/routes/manage_server_route.dart';
import 'package:slservers/widgets/register_instance_dialog.dart';

class MyServersBody extends StatefulWidget {
  MyServersBody({Key key}) : super(key: key);

  @override
  _MyServersBodyState createState() => _MyServersBodyState();
}

class _MyServersBodyState extends State<MyServersBody> {
  
  List<Server> servers;

  static const String ICON_FALLBACK = "https://i.imgur.com/eozgscT.jpg";

  bool isConfirmed = false;

  String buffer = "";
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Networks", style: GoogleFonts.raleway(fontSize: 25),),
        Container(
          height: 520,
          child: Wrap(
            children: (servers??[]).map((e) => serverWidget(e)).toList(),
          ),
        ),
      ],
    );
  }

  Widget serverWidget(Server server) {
    String url = server.iconUrl??ICON_FALLBACK;
    print(url);
    
    return FutureBuilder(
      future: prominentColor(url),
      builder: (x,y) {
        if (y.connectionState == ConnectionState.done) {

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 200,
              height: 500,
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: ColorConstants.background[600],
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                color: ColorConstants.background[600],
                                child: Image.network(url)
                            ), flex: 1, fit: FlexFit.tight,
                          ),
                          Expanded(
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: y.data
                                ),
                                alignment: Alignment.center,child: Text(server.name, style: GoogleFonts.roboto(fontSize: 25,),)
                            ),
                          ),
                          Container(height: 10,)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      color: ColorConstants.background[600],
                      width: 300,
                      child: Column(
                        children: [
                          RaisedButton(color: y.data, child: Text("Edit 🔧"), onPressed: () {
                            SLServers.router.navigateTo(context, "/edit/${server.id}");
                          }),
                          RaisedButton(color: y.data, child: Text("Add Instance 🔗"), onPressed: () {
                            showDialog(context: context, builder: (ctx) {
                              return RegisterInstanceDialog(server: server,);
                            });
                          }),
                          RaisedButton(color: y.data, child: Text("Statistics 📊"), onPressed: () {
                            ManageServerRoute.showSnack(context, Colors.orangeAccent, "🚧 This feature is not yet implemented 🚧");
                          }),
                          Expanded(
                            child: Container(),
                          ),
                          RaisedButton(color: Colors.redAccent, child: Text("Delete 🗑️"), onPressed: () async  {
                            if (!isConfirmed) {
                              isConfirmed = true;
                              ManageServerRoute.showSnack(context, Colors.redAccent, "Do you really want to delete your network? Press the button again to confirm");
                              return;
                            } else {
                              isConfirmed = false;
                              ManageServerRoute.showSnack(context, Colors.redAccent, "The network instance has been deleted");
                              await Servers.delete(server);
                              Servers.myServers().then((value) => setState(() {
                                servers = value;
                              }));
                            }
                          })
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return Container(
          width: 200,
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Servers.myServers().then((value) => setState(() {
      servers = value;
    }));
  }
}