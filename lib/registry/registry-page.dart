import 'package:first_app/registry/registry.dart';
import 'package:flutter/material.dart';

class RegistryPage extends StatelessWidget {
  RegistryPage({Key key, this.title, this.registry}) : super(key: key);

  final String title;
  final Future<List<Registry>> registry;

  /* @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Registrierung"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTextbox("Vorname"),
              _buildTextbox("Nachname"),
              _buildTextbox("Email"),
              _buildTextbox("Passwort"),
              _buildTextbox("Passwort wiederholen"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextbox(
    String nameValue,
    /* IconData iconNameValue */
  ) {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(
          labelText: nameValue,
          /* icon: Icon(iconNameValue),
          hintStyle: TextStyle(
            backgroundColor: Colors.blue[900],
            color: Colors.white,
          ), */
        ),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: FutureBuilder<List<Registry>>(
                future: this.registry,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();
                    default:
                      if (snapshot.hasError)
                        return new Text('Error: ${snapshot.error}');
                      else
                        return _buildGridView(context, snapshot.data);
                  }
                })));
  }

  Widget _buildGridView(BuildContext context, List<Registry> registry) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(1.5),
      crossAxisCount: determineCrossAxisCount(context),
      childAspectRatio: 1.2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: _prepareServerInfoCards(registry), //new Cards()
      shrinkWrap: true,
    );
  }

  List<Widget> _prepareServerInfoCards(List<Registry> registry) {
    List<Widget> serverInfoCells = [];
    // we can call the rest service here?
    for (Registry registry in registry) {
      serverInfoCells.add(_getServerInfoCard(registry));
    }

    return serverInfoCells;
  }

  Container _getServerInfoCard(Registry registry) {
    return new Container(
        width: 200.0,
        height: 150.0,
        child: Card(
          elevation: 2.0,
          color: Colors.lime,
          child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: _prepareStatusText(registry)),
        ));
  }

  List<Widget> _prepareStatusText(Registry registry) {
    final TextStyle textStyle =
        TextStyle(fontWeight: FontWeight.bold, height: 3);
    return <Widget>[
      new Center(
        child: new Text(registry.firstName, style: textStyle),
      ),
      new Center(
        child: _createStatusTable(registry),
      ),
    ];
  }

  Widget _createStatusTable(Registry registry) {
    if (registry == null) {
      return new Text('Server unreachable');
    }
    return Table(
        border: TableBorder.all(
            color: Colors.red[900], width: 1, style: BorderStyle.none),
        children: _createStatusCells(registry));
  }

  List<TableCell> _prepareHeader() {
    final TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
    return [
      TableCell(
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("firstName", style: textStyle))),
      TableCell(child: Center(child: Text("lastName", style: textStyle))),
      TableCell(child: Center(child: Text("gender", style: textStyle))),
    ];
  }

  List<TableRow> _createStatusCells(Registry info) {
    List<TableRow> rows = [];
    // prepare header
    rows.add(TableRow(children: _prepareHeader()));
    // prepare data
    rows.add(TableRow(children: [
      TableCell(
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(info.firstName, textAlign: TextAlign.left))),
      TableCell(
          child: Center(child: Text(info.lastName, textAlign: TextAlign.left))),
      TableCell(
          child: Center(child: Text(info.gender, textAlign: TextAlign.left))),
    ]));
    // }
    return rows;
  }

  int determineCrossAxisCount(BuildContext context) {
    int _crossAxisCount = 1;
    final double screenWidthSize = MediaQuery.of(context).size.width;
    if (screenWidthSize > 820) {
      _crossAxisCount = 4;
    } else if (screenWidthSize > 720) {
      _crossAxisCount = 3;
    } else if (screenWidthSize > 520) {
      _crossAxisCount = 2;
    } else {
      _crossAxisCount = 1;
    }

    return _crossAxisCount;
  }
}
