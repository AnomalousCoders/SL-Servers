import 'package:firebase_core/firebase_core.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slservers/routes/create_route.dart';
import 'package:slservers/routes/handlers.dart';
import 'package:slservers/routes/home_route.dart';
import 'package:slservers/routes/login_route.dart';
import 'package:slservers/routes/manage_server_route.dart';

import 'models/server.dart';

void main() {
  runApp(SLServers());
}

class SLServers extends StatelessWidget {

  static FirebaseApp firebase = FirebaseApp(name: "SL Servers");

  static Server currentlySelectedServer;

  static final Router router = Router();

  @override
  Widget build(BuildContext context) {
    _defineRoutes(router);
    return MaterialApp(
      title: 'SL Servers',
      theme: ThemeData(
        brightness: Brightness.dark,

        primarySwatch: ColorConstants.primary,
        accentColor: ColorConstants.accentColor,
        backgroundColor: ColorConstants.background,
        scaffoldBackgroundColor: ColorConstants.background[700],

        tooltipTheme: TooltipThemeData(textStyle: GoogleFonts.raleway(color: Colors.white), decoration: BoxDecoration(
          color: ColorConstants.background.shade400
        ), padding: EdgeInsets.all(8)),


        visualDensity: VisualDensity.comfortable,
      ),
      onGenerateRoute: router.generator,
      routes: {
        "/login": (_) => LoginRoute(),
        "/create": (_) => CreateRoute(),
        "/myServers": (_) => ManageServerRoute(),
        "/": (_) => HomeRoute(),
      },
      initialRoute: "/",
    );
  }

  void _defineRoutes(Router router) {
    router.define("/server/:server", handler: ServerHandler(), transitionType: TransitionType.fadeIn);
    router.define("/list/:page", handler: ListHandler(), transitionType: TransitionType.fadeIn);
    router.define("/list/:page/local", handler: LocalizedListHandler(), transitionType: TransitionType.fadeIn);
  }

}

class ColorConstants {

  static const MaterialColor background = MaterialColor(0xff23272A, {
    100: Color.fromARGB(255, 110,110,110),
    200: Color.fromARGB(255, 79,79,80),
    300: Color.fromARGB(255, 67,68,68),
    400: Color.fromARGB(255, 55,55,55),
    500: Color.fromARGB(255, 46,46,46),
    600: Color.fromARGB(255, 34,34,34),
    700: Color.fromARGB(255, 20,20,20),
    800: Color.fromARGB(255, 0,0,0),
  });

  /*
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
  */

  //    50: Color(0xFFeb3349),
  //    100: Color(0xFFeb3349),
  //    200: Color(0xFFeb3349),
  //    300: Color(0xFFeb3349),
  //    400: Color(0xFFeb3349),
  //    500: Color(0xFFeb3349),
  //    600: Color(0xFFeb3349),
  //    700: Color(0xFFeb3349),
  //    800: Color(0xFFeb3349),
  //    900: Color(0xFFeb3349),

  static const MaterialColor primary = MaterialColor(0xFF7289DA, {

  });

  static Gradient primaryGradient = LinearGradient(colors: [Color(0xFF7289DA), Color(0xFF8ea1e1)]);
  //static Gradient primaryGradient = LinearGradient(colors: [Color(0xFFeb3349), Color(0xFFf45c43)]);

  static Gradient cardGradient = LinearGradient(colors: [background[600], background[500]], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static const Color secondary = Colors.white;
  static const Color secondaryShade = Color(0xff99AAB5);

  static const MaterialAccentColor accentColor = MaterialAccentColor(0xff919395, {
    100: Color(0xff23272A),
    200: Color(0xff65686A),
    400: Color(0xffBDBEBF),
    500: Color(0xffE5E5E5),
  });

}