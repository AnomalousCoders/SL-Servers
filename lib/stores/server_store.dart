import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/models/server.dart';

part 'server_store.g.dart';

class ServerStore extends _ServerStore with _$ServerStore{

  ServerStore(String id, bool admin) : super(id, admin);

}

enum StoreState { loading, loaded }

abstract class _ServerStore with Store {

  final String _id;
  final bool _admin;

  @observable
  ObservableFuture<Server> serverFuture;

  @observable
  Server server;

  @observable
  String errorMessage;

  _ServerStore(this._id, this._admin);

  @computed
  StoreState get state {

    if (serverFuture == null || serverFuture.status != FutureStatus.fulfilled) {
      return StoreState.loading;
    }
    return StoreState.loaded;

  }

  void dispose() {

  }

  @action
  Future update(BuildContext context, Server server) async {
    await Servers.update(server);
    await load(context);
    return;
  }

  @action
  Future load(BuildContext context) async {
    try {
      errorMessage = null;
      serverFuture = ObservableFuture(Servers.preloadId(_id, context, adminLoad: _admin));
      server = await serverFuture;
    } on Exception {
      errorMessage = "Couldn't fetch requested server";
      print("Error when fetching");
    }
  }

}
