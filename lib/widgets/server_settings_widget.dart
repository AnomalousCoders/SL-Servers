import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/models/server.dart';
import 'package:slservers/stores/server_store.dart';
import 'package:slservers/widgets/validating_textfield.dart';
import 'package:stylight/stylight.dart';
import 'package:validators/validators.dart';

class ServerSettingsWidget extends StatefulWidget {
  ServerSettingsWidget({Key key, this.server}) : super(key: key);

  Server server;

  @override
  _ServerSettingsWidgetState createState() => _ServerSettingsWidgetState(server);
}

class _ServerSettingsWidgetState extends State<ServerSettingsWidget> {

  Server server;

  _ServerSettingsWidgetState(this.server);

  @override
  void initState() {
    if (server==null) server = new Server(languages: [], comments: [], instances: [], tags: [], rules: [], autogenerated: false, visible: false, description: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ServerStore store = Provider.of<ServerStore>(context);

    Size size = MediaQuery.of(context).size;
    size = new Size((size.width / 5 ) * 4, size.height);

    return ListView(
      children: [
        Container(height: 64,),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextStyles.Title1.text("General Settings"),
        ),

        Row(
          children: [
            Container(
              width: size.width / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(controller: TextEditingController(text: server.name), onChanged: (s) => server.name = s, decoration: InputDecoration(labelText: "Name", border: OutlineInputBorder(), filled: true, fillColor: Colors.black12),),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: size.width / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(controller: TextEditingController(text: server.preview), onChanged: (s) => server.preview = s, decoration: InputDecoration(labelText: "Preview", border: OutlineInputBorder(), filled: true, fillColor: Colors.black12),),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: size.width / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(controller: TextEditingController(text: server.rules.join(";")), onChanged: (s) => server.rules = s.split(";").map((e) => e.trim()).toList(), decoration: InputDecoration(labelText: "Rules", border: OutlineInputBorder(), filled: true, fillColor: Colors.black12, helperText: "Entries are ; separated"),),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: size.width / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(controller: TextEditingController(text: server.tags.join(";")), onChanged: (s) => server.tags = s.split(";").map((e) => e.trim()).toList(), decoration: InputDecoration(labelText: "Tags", border: OutlineInputBorder(), filled: true, fillColor: Colors.black12, helperText: "Entries are ; separated")),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              width: size.width / 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: TextField(controller: TextEditingController(text: server.languages.join(";")), onChanged: (s) => server.languages = s.split(";").map((e) => e.trim()).toList(), decoration: InputDecoration(labelText: "Languages", border: OutlineInputBorder(), filled: true, fillColor: Colors.black12, helperText: "Entries are ; separated")),
              ),
            ),
          ],
        ),

        Container(height: 16,),

        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Container(
              child: ValidatingTextfield(width: (size.width * 0.75 / 2 - 16) ,initial: server.icon, onSuccessful: (s) => server.icon = s, label: "Icon", helper: "Imgur url of your server icon. Upload your icon to imgur, click on the copy button\nand paste the url here", validator: (s) {
                return isAlphanumeric(s) && s.length == 7;
              }, refactor: (s) {
                if (isURL(s, hostWhitelist: ["imgur.com"])) {
                  String extracted = s.split("imgur.com/")[1];
                  return extracted;
                } else {
                  return s;
                }
              }),
            )
        ),

        Container(height: 16,),

        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(child: TextStyles.SubHeader.text("Refresh", color: textColor1), onPressed: refresh),
              Container(width: 16,),
              RaisedButton(child: TextStyles.SubHeader.text("Save Changes", color: textColor1), onPressed: saveChanges, color: Hues.Green.hard,),
            ],
          ),
        ),

        Divider(thickness: 2, indent: 128, endIndent: 128,),


        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
            child: Card(
              color: primary[800],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextStyles.Title2.text("Dangezone"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(child: Text("Delete Network"), onPressed: () async {
                          await Servers.update(server);
                          success(context, "Network deleted");
                        }, color: Hues.Red.hard,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        Container(height: 16,)
      ],
    );
  }

  void saveChanges() {
    Provider.of<ServerStore>(context, listen: false).update(context, server);
    success(context, "Server settings updated");
  }

  void refresh() {
    Provider.of<ServerStore>(context, listen: false).load(context);
    warning(context, "Server settings reloaded");
  }

}