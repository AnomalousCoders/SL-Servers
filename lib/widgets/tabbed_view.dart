import 'package:flutter/material.dart';
import 'package:slservers/main.dart';

class TabbedView extends StatefulWidget {

  List<Widget> navigation;
  List<Widget Function()> widgets;

  double width;
  double height;


  TabbedView({this.navigation, this.widgets, this.width, this.height});

  @override
  _TabbedViewState createState() => _TabbedViewState(this);
}

class _TabbedViewState extends State<TabbedView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  int index = 0;

  TabbedView tabbedView;

  _TabbedViewState(this.tabbedView);

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(children: tabbedView.navigation.map((e) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(onTap: () => setState(() {index = tabbedView.navigation.indexOf(e); }),child: e,),
          )).toList(), mainAxisAlignment: MainAxisAlignment.center,),
          height: 60,
          width: tabbedView.width,
          color: ColorConstants.background.shade700,
        ),
        Container(
          alignment: Alignment.topLeft,
            child: FittedBox(child: currentTab)
        )
      ],
    );
  }

  Widget get currentTab => tabbedView.widgets[index]();
}
