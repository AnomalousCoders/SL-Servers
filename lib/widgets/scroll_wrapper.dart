import 'package:flutter/material.dart';
import 'package:slservers/widgets/footer.dart';
import 'package:slservers/widgets/raw_keyboard_widget.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';

class ScrollWrapper extends StatelessWidget {

  final Widget child;
  bool wrapScreenSize;
  bool removeFooter;

  ScrollWrapper({this.child, this.wrapScreenSize = false, this.removeFooter = false});

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return RawKeyboardWidget(
      child: Scrollbar(
        controller: scrollController,
        isAlwaysShown: !removeFooter,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: <Widget>[
              SyncSwitchWidget(
                positive: Container(
                  width: width,
                  height: height,
                  child: child,
                ),
                negative: child,
                boolean: wrapScreenSize,
              ),
              removeFooter ? Container() : Footer()
            ],
          ),
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics()
        ),
      ),
    );
  }

}
