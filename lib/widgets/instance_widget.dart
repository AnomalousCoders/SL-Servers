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
            Text("Server IP", style: GoogleFonts.raleway(color: Colors.white70, fontWeight: FontWeight.bold),),
            Text(instance.address, style: GoogleFonts.roboto(fontSize: 20),),
            Container(height: 16,),
            Text("Description", style: GoogleFonts.raleway(color: Colors.white70, fontWeight: FontWeight.bold),),
            Text(instance.description, style: GoogleFonts.roboto(fontSize: 20),)
          ],
        ),
      ),
    );
  }
}