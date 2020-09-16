import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/security/auth_manager.dart';
import 'package:slservers/stores/server_store.dart';
import 'package:slservers/widgets/instance_widget.dart';
import 'package:slservers/widgets/login_status.dart';
import 'package:slservers/widgets/register_instance_dialog.dart';
import 'package:slservers/widgets/scroll_wrapper.dart';
import 'package:slservers/widgets/server_description_widget.dart';
import 'package:slservers/widgets/server_settings_widget.dart';
import 'package:slservers/widgets/server_social_widget.dart';
import 'package:stylight/stylight.dart';

import '../main.dart';

class InstanceRoute extends StatefulWidget {
  InstanceRoute({Key key, this.id}) : super(key: key);

  String id;

  @override
  _InstanceRouteState createState() => _InstanceRouteState(this);
}

class _InstanceRouteState extends State<InstanceRoute> {

  InstanceRoute parent;

  _InstanceRouteState(this.parent);

  static GlobalKey scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => ServerStore(parent.id, true)..load(context),
      child: Scaffold(
        key: scaffoldKey,
        body: AuthManager(
          ignoreLogin: false,
          child: (context) => ScrollWrapper(
            wrapScreenSize: true,
            removeFooter: true,
            child: Column(
              children: [
                Hero(
                  tag: SLServers.AppBarHero,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: primary[700],
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          LoginStatus()
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SettingsView(pages: 1, navigation: ["General","Description", "Social", "Instances"],builder: (ctx,i) {
                    ServerStore serverStore = Provider.of<ServerStore>(ctx);
                    switch(i) {
                      case 0:
                        return Observer(
                            builder: (_) {
                              switch (serverStore.state) {
                                case StoreState.loading:
                                  return LoadingIndicator();
                                case StoreState.loaded:
                                  return ServerSettingsWidget(server: serverStore.server,);
                              }
                              return Container();
                            }
                        );

                        return FutureBuilder(builder: (x,y) {
                          if (y.connectionState != ConnectionState.done) {
                            return Center(child: CircularProgressIndicator(),);
                          }

                          return ServerSettingsWidget(server: y.data,);
                        }, future: Servers.preloadId(parent.id, context, adminLoad: true));

                      case 1:
                        return Observer(
                          builder: (context) {
                            switch (serverStore.state) {
                              case StoreState.loading:
                                return LoadingIndicator();
                              case StoreState.loaded:
                                return ServerDescriptionWidget(server: serverStore.server,);
                            }
                            return Container();
                          },
                        );


                      case 2:
                        return Observer(
                          builder: (context) {
                            switch (serverStore.state) {
                              case StoreState.loading:
                                return LoadingIndicator();
                              case StoreState.loaded:
                                return ServerSocialWidget(server: serverStore.server,);
                            }
                            return Container();
                          });

                      case 3:
                        return Observer(builder: (_) {
                          switch(serverStore.state) {

                            case StoreState.loading:
                              return LoadingIndicator();
                            case StoreState.loaded:
                              return Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: GridView.count(crossAxisCount: 2, children: (serverStore.server).instanceRefs.map((e) => InstanceConfigWidget(serverStore.server, e) as Widget).toList()
                                        ..addAll((serverStore.server).pendingRefs.map((e) => PendingWidget(e)).toList()),

                                        mainAxisSpacing: 32, crossAxisSpacing: 32, childAspectRatio: 2 / 1.25,),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(onPressed: () {
                                          showDialog(context: context, builder: (ctx) {
                                            return new RegisterInstanceDialog(server: serverStore.server,);
                                          });
                                        }, child: TextStyles.SubHeader.text("Register Instance", color: textColor1), color: Hues.Green.hard,)
                                      ],
                                    )
                                  ],
                                ),
                              );
                          }
                          return Container();
                        });
                    }

                    return Container();
                  }),
                ),
              ],
            )
          ),
        ),
      ),
    );
  }
}