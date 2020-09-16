import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:slservers/routes/create_route.dart';
import 'package:slservers/routes/handlers.dart';
import 'package:slservers/routes/home_route.dart';
import 'package:slservers/routes/login_route.dart';
import 'package:slservers/routes/manage_server_route.dart';
import 'package:stylight/stylight.dart';

import 'models/server.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(SLServers());
}

class SLServers extends StatelessWidget {

  static GlobalKey AppBarHero = new GlobalKey();

  static Server currentlySelectedServer;

  static final Router router = Router();

  @override
  Widget build(BuildContext context) {
    _defineRoutes(router);
    return MaterialApp(
      title: 'SL Servers',
      debugShowCheckedModeBanner: false,
      theme: Sty.sty.theme.copyWith(hoverColor: Colors.transparent),
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
    router.define("/server/:server", handler: ServerHandler(), transitionType: TransitionType.material);
    router.define("/list/:page", handler: ListHandler(), transitionType: TransitionType.material);
    router.define("/list/:page/local", handler: LocalizedListHandler(), transitionType: TransitionType.material);
    router.define("/edit/:network", handler: EditHandler(), transitionType: TransitionType.material);
    router.define("/instances/:server", handler: InstancesHandler(), transitionType: TransitionType.material);
  }

}

class ColorConstants {

  static const MaterialColor background = primary;
  /*
  MaterialColor(0xff23272A, {
    100: Color.fromARGB(255, 110,110,110),
    200: Color.fromARGB(255, 79,79,80),
    300: Color.fromARGB(255, 67,68,68),
    400: Color.fromARGB(255, 55,55,55),
    500: Color.fromARGB(255, 46,46,46),
    600: Color.fromARGB(255, 34,34,34),
    700: Color.fromARGB(255, 20,20,20),
    800: Color.fromARGB(255, 0,0,0),
  });

   */

  //static const MaterialColor primary = MaterialColor(0xFF7289DA, {});

  static Gradient primaryGradient = LinearGradient(colors: [Hues.Blue.hard, Hues.Blue.hard]);

  //static Gradient cardGradient = LinearGradient(colors: [background[600], background[500]], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static Gradient cardGradient = LinearGradient(colors: [primary[600], primary[600]], begin: Alignment.topCenter, end: Alignment.bottomCenter);

  static const Color secondary = Colors.white;
  static const Color secondaryShade = Color(0xff99AAB5);

  static const MaterialAccentColor accentColor = MaterialAccentColor(0xff919395, {
    100: Color(0xff23272A),
    200: Color(0xff65686A),
    400: Color(0xffBDBEBF),
    500: Color(0xffE5E5E5),
  });

}