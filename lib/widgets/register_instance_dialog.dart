import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/models/server.dart';

import '../main.dart';

class RegisterInstanceDialog extends StatefulWidget {


  RegisterInstanceDialog({Key key, this.server}) : super(key: key);

  Server server;

  @override
  _RegisterInstanceDialogState createState() => _RegisterInstanceDialogState(this);
}

class _RegisterInstanceDialogState extends State<RegisterInstanceDialog> {

  String buffer = "";

  String responseToken = "";

  RegisterInstanceDialog parent;

  _RegisterInstanceDialogState(this.parent);

  @override
  Widget build(BuildContext context) {
    return Dialog(child: Container(
      alignment: Alignment.center,
      width: 400,
      height: 600,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: responseToken == "" ? _requestWidgets() : _responseWidgets(),
        ),
      ),
    ), backgroundColor: ColorConstants.background[700],);
  }

  List<Widget> _requestWidgets() {
    return [
      Image.network("https://imgur.com/tRBL0DB.png", height: 200, width: 200,),
      Container(height: 8,),
      Text("Register Server Instance", style: GoogleFonts.raleway(fontSize: 20, fontWeight: FontWeight.w700),),
      Expanded(child: Container(),),
      TextField(onChanged: (b) => buffer = b, decoration: InputDecoration(labelText: "Server Address", helperText: "The server address of the instane you want to add\nFormat: <host>:<port>"),),
      RaisedButton(onPressed: () async {
        responseToken = await Servers.registerServer(parent.server, buffer);
        print("Token: " + responseToken);
        setState(() {});
      }, child: Text("Generate Token"),),
      Expanded(child: Container(),),
    ];
  }

  List<Widget> _responseWidgets() {
    return [
      Expanded(child: Container(),),
      Text("Action required", style: GoogleFonts.raleway(fontSize: 25, color: ColorConstants.primary),),
      Container(height: 8,),
      Text("A claim request of '$buffer' has been created. Add the token bellow to your server information (not the PasteBin description) in order verify your ownership of the server. "
          "The verification should not take longer than 2 minutes. If your verification has not completed after given time and you're sure your input is correct, please contact us through our discord server",
        style: GoogleFonts.ubuntu(fontSize: 15, color: Colors.white70), textAlign: TextAlign.center,
      ),
      TextField(readOnly: true, maxLines: 1, controller: TextEditingController(text: responseToken), style: TextStyle(fontSize: 10), decoration: InputDecoration(suffix:  IconButton(icon: Icon(Icons.content_copy), onPressed: () {
        Clipboard.setData(ClipboardData(text: responseToken));
      })),),
      Expanded(child: Container(),),
      RaisedButton(child: Text("Close"),onPressed: () {
        Navigator.of(context).pop();
      }),
      Container(height: 16,)
    ];
  }

}