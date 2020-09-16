import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/main.dart';
import 'package:slservers/models/pending_verification.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/models/server_instance.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';
import 'package:stylight/stylight.dart';

class InstanceWidget extends StatefulWidget {
  InstanceWidget({Key key, this.instance, this.sendToast}) : super(key: key);

  ServerInstance instance;
  Function(String, Color) sendToast;

  @override
  _InstanceWidgetState createState() => _InstanceWidgetState(instance, this);
}

class _InstanceWidgetState extends State<InstanceWidget> {

  InstanceWidget parent;
  ServerInstance instance;

  _InstanceWidgetState(this.instance, this.parent);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstants.background[700],
      child: Container(
        padding: EdgeInsets.all(16),
        color: ColorConstants.background[700],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                    child: Text(instance.name, style: GoogleFonts.raleway(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              ),
              Container(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextStyles.Header.text("Server Address"),
                              Container(height: 2,),
                              TextStyles.Title3.text(instance.address??"invalid", color: textColor2),
                            ],
                          ),
                        ),
                        Container(
                          height:50,
                          alignment: Alignment.bottomCenter,
                          child: MouseRegion(
                            child: IconButton(onPressed: () {
                              parent.sendToast("Copied Address to Clipboard", Colors.blue);
                              Clipboard.setData(ClipboardData(text: instance.address));
                            }, icon: Icon(EvaIcons.copyOutline, size: 25,), color: textColor2,),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextStyles.Header.text("Players"),
                          TextStyles.Title3.text("${instance.players??0}/${instance.maxplayers??0}", color: instance.maxplayers - instance.players == 0 ? Hues.Red.hard : textColor2, font: Fonts.OpenSans),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(height: 16,),
              TextStyles.Header.text("Description"),
              Text(instance.description, style: TextStyles.Body.style, maxLines: 3,),
              Container(height: 16,),
              Divider(color: primary[500], thickness: 2,),
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
                            TextStyles.Header.text("Version"),
                            Container(height: 2,),
                            TextStyles.Body.text(instance.version??"none", color: textColor2)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextStyles.Header.text("NW Verified"),
                            Icon(instance.verified??false ? Icons.check : Icons.clear, color: instance.verified??false ? Hues.Green.hard : Hues.Red.hard,)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextStyles.Header.text("Friendly Fire"),
                            Icon(instance.ff??false ? Icons.check : Icons.clear, color: instance.ff??false ? Hues.Green.hard : Hues.Red.hard,)
                          ],
                        ),
                      ),
                    ],
                  ),
                 SyncSwitchWidget(
                   boolean: (instance.plugins??[]).length > 0,
                   positive: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: <Widget>[
                       Column(
                         mainAxisAlignment: MainAxisAlignment.start,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                           TextStyles.Header.text("Plugins"),
                           Container(height: 2,),
                           TextStyles.Body.text((instance.plugins??[]).join(" ")),
                         ],
                       ),
                     ],
                   ),
                   negative: Container(),
                 )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InstanceConfigWidget extends StatefulWidget {

  ServerInstance instance;
  Server server;

  InstanceConfigWidget(this.server, this.instance);

  @override
  _InstanceConfigWidgetState createState() => _InstanceConfigWidgetState(this);
}

class _InstanceConfigWidgetState extends State<InstanceConfigWidget> {

  InstanceConfigWidget parent;

  _InstanceConfigWidgetState(this.parent);

  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: ColorConstants.background[600],
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                      child: SyncSwitchWidget(
                        negative: InstanceWidget(instance: parent.instance, sendToast: (_,__) {},),
                        positive: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            color: ColorConstants.background[700],
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextField(controller: TextEditingController(text: parent.instance.name), decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder()), onChanged: (s) {
                                    parent.instance.name = s;
                                  },),
                                  TextField(controller: TextEditingController(text: parent.instance.description), decoration: InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                                  keyboardType: TextInputType.multiline, minLines: 1, maxLines: 3, onChanged: (s) {
                                    parent.instance.description = s;
                                  }),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(controller: TextEditingController(text: parent.instance.plugins.join(";")), onChanged: (s) => parent.instance.plugins = s.split(";").map((e) => e.trim()).toList(), decoration: InputDecoration(labelText: "Languages", border: OutlineInputBorder(), filled: true, fillColor: Colors.black12, helperText: "Entries are ; separated")),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        boolean: isEditing,
                      ),
                    flex: 3, fit: FlexFit.tight,
                  ),
                  Flexible(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GridPadding(
                            child: RaisedButton(child:  TextStyles.SubHeader.text(isEditing ? "Save" : "Edit", color: textColor1), onPressed: () {
                              setState(() {
                                if (isEditing) {
                                  Servers.updateInstance(parent.server, parent.instance).then((value) => {
                                    success(context, "Updates applied successfully. It can take up to a minute for the changes to take effect")
                                  }, onError: (value) => {
                                    error(context, "Upates can't be applied")
                                  });
                                }

                                isEditing = !isEditing;
                              });
                            }),
                          ),

                          GridPadding(
                            child: RaisedButton(child: TextStyles.SubHeader.text("Delete", color: textColor1), color: Hues.Red.hard, onPressed: () {
                              setState(() {
                                Servers.deleteInstance(parent.server, parent.instance).then((value) => {
                                  error(context, "Instance has been deleted")
                                });
                              });
                            }),
                          )
                        ],
                      ),
                    ),
                    flex: 1,
                  )
                ],
              ), flex: 5, fit: FlexFit.tight,
            ),
          ],
        ),
      ),
    );
  }
}

class PendingWidget extends StatelessWidget {

  final PendingVerification verification;

  PendingWidget(this.verification);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        color: ColorConstants.background[600],
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: GridPadding(
          multiple: 2,
          child: Column(
            children: [
              TextStyles.Title1.text("Instance Verification"),
              TextStyles.Title3.text(verification.address, color: textColor2),

              GridPadding(
                multiple: 4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextStyles.Header.text("Verification ID"),
                          Container(height: 2,),
                          TextStyles.Title3.text(verification.id, color: textColor2),
                        ],
                      ),
                    ),

                    Container(
                      height: 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextStyles.Header.text("Network ID"),
                          Container(height: 2,),
                          TextStyles.Title3.text(verification.network, color: textColor2),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              GridPadding(child: TextField(controller: TextEditingController(text: verification.verToken),readOnly: true, decoration: InputDecoration(suffix: IconButton(icon: Icon(Icons.content_copy), onPressed: () {
                Clipboard.setData(ClipboardData(text: verification.verToken));
              }), helperText: "Paste this into the info of your server in order to verify your ownership", labelText: "Verification Token")), top: false, bottom: false, multiple: 4),

              Expanded(
                child: Container(),
              ),

              Container(
                width: 100,
                child: RaisedButton(child: TextStyles.SubHeader.text("Delete", color: textColor1), color: Hues.Red.hard, onPressed: () {
                  error(context, "Verification request deleted");
                }),
              ),

              Expanded(
                child: Container(),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
