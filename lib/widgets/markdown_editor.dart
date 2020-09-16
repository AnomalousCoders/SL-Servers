import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;

class MarkdownEditor extends StatefulWidget {
  MarkdownEditor({Key key, this.width, this.callback, this.initial}) : super(key: key);

  String initial;
  Function(String) callback;

  double width;

  @override
  _MarkdownEditorState createState() => _MarkdownEditorState(this);
}

class _MarkdownEditorState extends State<MarkdownEditor> {

  TextEditingController controller;

  MarkdownEditor parent;

  _MarkdownEditorState(this.parent);

  @override
  void initState() {
    controller = new TextEditingController(text: parent.initial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  width: parent.width / 2,
                  child: Text("CommonMark & HTML", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),)),
              Container(
                  alignment: Alignment.center,
                  width: parent.width / 2,
                  child: Text("Preview", style: GoogleFonts.raleway(fontWeight: FontWeight.bold, color: Colors.white70),)),
            ],
          ),
        ),
        Container(
          color: Colors.black12,
          width: parent.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: parent.width / 2,
                child: TextField(controller: controller, decoration: InputDecoration(labelText: "Description", border: OutlineInputBorder()),
                    keyboardType: TextInputType.multiline, minLines: 4, maxLines: 99, onChanged: (s) {
                      parent.callback(s);
                      setState(() {});
                    }),
              ),
              Container(
                  width: parent.width / 2,
                  color: Colors.black12,
                  child: Scrollbar(
                    child: HtmlWidget(
                      md.markdownToHtml(controller.text,extensionSet: md.ExtensionSet.commonMark, inlineOnly: false).replaceAll("\n", "<br>"),
                    ),
                  )
              )
            ],
          ),
        ),
      ],
    );
  }
}