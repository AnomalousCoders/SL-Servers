import 'package:flutter/cupertino.dart';

class Flags {

  static const FlagWidget DE = FlagWidget(language: "de");
  static const FlagWidget EN = FlagWidget(language: "en",);
  static const FlagWidget ES = FlagWidget(language: "es",);
  static const FlagWidget FR = FlagWidget(language: "fr");
  static const FlagWidget PL = FlagWidget(language: "pl",);

}

class FlagWidget extends StatelessWidget {

  final String language;

  const FlagWidget({this.language}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network("flags/$language.png"),
    );
  }

}