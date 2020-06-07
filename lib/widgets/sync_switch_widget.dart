import 'package:flutter/material.dart';

class SyncSwitchWidget extends StatelessWidget {


  final Widget positive;
  final Widget negative;
  final bool boolean;

  const SyncSwitchWidget({Key key, this.positive, this.negative, this.boolean}) : super(key: key);


  Widget build(BuildContext context) {
    return boolean ? positive : negative;
  }
}
