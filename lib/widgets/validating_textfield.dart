import 'package:flutter/material.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';

class ValidatingTextfield extends StatefulWidget {
  ValidatingTextfield({Key key, this.width, this.initial, this.label = "", this.helper = "", this.validator, this.onSuccessful, this.refactor}) : super(key: key);

  String initial;
  String label;
  String helper;
  double width;
  Function(String) onSuccessful;
  bool Function(String) validator;
  String Function(String) refactor = (s) => s;

  @override
  _ValidatingTextfieldState createState() => _ValidatingTextfieldState(this);
}

class _ValidatingTextfieldState extends State<ValidatingTextfield> {

  TextEditingController controller;

  ValidatingTextfield parent;

  _ValidatingTextfieldState(this.parent);


  @override
  void initState() {
    if (parent.refactor == null) parent.refactor = (s) => s;
    controller = new TextEditingController(text: parent.initial);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: parent.width,
      child: Row(
        children: <Widget>[
          Container(
            width: parent.width / 10 * 8,
            child: TextField(controller: controller, onChanged: (s) {
              String refactored = parent.refactor(s);
              if (refactored != s) {
                controller.text = refactored;
                s = refactored;
              }
              if (parent.validator(s)) parent.onSuccessful(s);
              this.setState(() { });
            }, decoration: InputDecoration(labelText: parent.label, border: OutlineInputBorder(), filled: true, fillColor: Colors.black12, helperText: parent.helper),),
          ),
          Container(
            width: parent.width / 10 * 2,
            alignment: Alignment.center,
            child: SyncSwitchWidget(
              boolean: controller.text == "",
              positive: Text("/", style: TextStyle(fontSize: 48, color: Colors.white60),),
              negative: SyncSwitchWidget(
                boolean: parent.validator(controller.text),
                positive: Icon(Icons.check, color: Colors.lightGreenAccent, size: 48,),
                negative: Icon(Icons.clear, color: Colors.redAccent, size: 48,),
              ),
            ),
          )
        ],
      ),
    );
  }
}