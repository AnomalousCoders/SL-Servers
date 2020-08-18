import 'package:flutter/material.dart';
import 'package:slservers/data/servers.dart';
import 'package:slservers/models/server.dart';

class MyServersBody extends StatefulWidget {
  MyServersBody({Key key}) : super(key: key);

  @override
  _MyServersBodyState createState() => _MyServersBodyState();
}

class _MyServersBodyState extends State<MyServersBody> {
  
  List<Server> servers;
  
  @override
  Widget build(BuildContext context) {
    List<DataColumn> columns = [DataColumn(label: Text("Name")), DataColumn(label: Text("Players")), DataColumn(label: Text("Actions")), DataColumn(label: Container())];
    List<DataRow> rows = servers.map((e) => DataRow(cells: [
      DataCell(Text(e.name)),
      DataCell(Text(e.players.toString())),
      DataCell(RaisedButton(child: Text("Edit"), onPressed: () {},)),
      DataCell(RaisedButton(child: Text("Add Instance"), onPressed: () {},))
    ])).toList();

    return DataTable(columns: columns, rows: rows,);
  }

  @override
  void initState() {
    super.initState();
    Servers.myServers().then((value) => setState(() {
      servers = value;
    }));
  }
}