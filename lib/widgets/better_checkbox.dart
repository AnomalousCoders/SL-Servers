import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BetterCheckbox extends StatefulWidget {
  BetterCheckbox({Key key, this.value, this.onChange, this.label}) : super(key: key);

  bool value;
  String label;
  Function(bool) onChange;

  @override
  _BetterCheckboxState createState() => _BetterCheckboxState(this);
}

class _BetterCheckboxState extends State<BetterCheckbox> {

  BetterCheckbox parent;

  _BetterCheckboxState(this.parent);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Checkbox(value: parent.value, onChanged: (b) {
          setState(() {});
          parent.value = b;
          parent.onChange(b);
        }, tristate: false, activeColor: Colors.lightGreen,),
        Text(parent.label, style: GoogleFonts.raleway(color: Colors.white70),)
      ],
    );
  }
}