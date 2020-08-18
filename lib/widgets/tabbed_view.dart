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
    return LayoutBuilder(
      builder: (ctx,con) {
        return Container(
          height: tabbedView.height,
          child: Card(
            color: ColorConstants.background[600],
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Container(
              decoration: BoxDecoration(
                  gradient: ColorConstants.cardGradient
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(children: tabbedView.navigation.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(onTap: () => setState(() {index = tabbedView.navigation.indexOf(e); }),child: e,),
                    )).toList(), mainAxisAlignment: MainAxisAlignment.center,),
                    height: 60,
                    width: tabbedView.width,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(thickness: 2,),
                  ),
                  Container(
                      width: tabbedView.width,
                      //color: ColorConstants.background.shade600,
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView(children: [Container(child: currentTab,)], shrinkWrap: true,),
                      )
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget get currentTab => tabbedView.widgets[index]();
}
