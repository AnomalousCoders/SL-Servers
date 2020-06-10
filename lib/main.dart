import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/routes/home_route.dart';
import 'package:slservers/routes/login_route.dart';

void main() {
  runApp(SLServers());
}

class SLServers extends StatelessWidget {

  static FirebaseApp firebase = FirebaseApp(name: "SL Servers");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SL Servers',
      theme: ThemeData(
        brightness: Brightness.dark,

        primarySwatch: ColorConstants.primary,
        accentColor: ColorConstants.accentColor,
        backgroundColor: ColorConstants.background,
        scaffoldBackgroundColor: ColorConstants.background,
        tooltipTheme: TooltipThemeData(textStyle: GoogleFonts.raleway(color: Colors.white), decoration: BoxDecoration(
          color: ColorConstants.background.shade400
        ), padding: EdgeInsets.all(8)),

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "login/": (_) => LoginRoute(),
        "/": (_) => HomeRoute()
      },
      initialRoute: "login",
    );
  }
}

class ColorConstants {

  static const MaterialColor background = MaterialColor(0xff23272A, {
    50: Color(0xffE5E5E5),
    100: Color(0xffBDBEBF),
    200: Color(0xff919395),
    300: Color(0xff65686A),
    400: Color(0xff44474A),
    500: Color(0xff23272A),
    600: Color(0xff1F2325),
    700: Color(0xff1A1D1F),
    800: Color(0xff151719),
    900: Color(0xff0C0E0F),
  });

  static const MaterialColor primary = MaterialColor(0xffBB0011, {
    50: Color(0xffF7E0E2),
    100: Color(0xffEBB3B8),
    200: Color(0xffDD8088),
    300: Color(0xffCF4D58),
    400: Color(0xffC52635),
    500: Color(0xffBB0011),
    600: Color(0xffB5000F),
    700: Color(0xffAC000C),
    800: Color(0xffA4000A),
    900: Color(0xff960005),
  });

  static const Color secondary = Colors.white;
  static const Color secondaryShade = Color(0xff99AAB5);

  static const MaterialAccentColor accentColor = MaterialAccentColor(0xff919395, {
    100: Color(0xff23272A),
    200: Color(0xff65686A),
    400: Color(0xffBDBEBF),
    500: Color(0xffE5E5E5),
  });

}