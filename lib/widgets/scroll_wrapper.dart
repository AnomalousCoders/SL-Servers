import 'package:flutter/material.dart';
import 'package:slservers/widgets/footer.dart';
import 'package:slservers/widgets/sync_switch_widget.dart';

class ScrollWrapper extends StatelessWidget {

  final Widget child;
  bool wrapScreenSize = false;

  ScrollWrapper({this.child, this.wrapScreenSize});

  ScrollController scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scrollbar(
      controller: scrollController,
      isAlwaysShown: true,
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
            Footer()
          ],
        ),
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics()
      ),
    );
  }

}
