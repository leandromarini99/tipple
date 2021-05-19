import 'package:flutter/material.dart';
import 'package:tipple_app/configuration/ingredient-configurator.dart';

class ConfiguratorPage extends StatelessWidget {
  ConfiguratorPage({Key key, this.title, this.configurations})
      : super(key: key);

  final String title;
  final Future<List<Configuration>> configurations;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: FutureBuilder<List<Configuration>>(
                future: this.configurations,
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

  Widget _buildGridView(
      BuildContext context, List<Configuration> configurations) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(1.5),
      crossAxisCount: determineCrossAxisCount(context),
      childAspectRatio: 1.2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: _prepareServerInfoCards(configurations), //new Cards()
      shrinkWrap: true,
    );
  }

  List<Widget> _prepareServerInfoCards(List<Configuration> configurations) {
    List<Widget> serverInfoCells = [];
    // we can call the rest service here?
    for (Configuration config in configurations) {
      serverInfoCells.add(_getServerInfoCard(config));
    }

    return serverInfoCells;
  }

  Container _getServerInfoCard(Configuration configurations) {
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
              children: _prepareStatusText(configurations)),
        ));
  }

  List<Widget> _prepareStatusText(Configuration configurations) {
    final TextStyle textStyle =
        TextStyle(fontWeight: FontWeight.bold, height: 3);
    return <Widget>[
      new Center(
        child: new Text(configurations.id, style: textStyle),
      ),
      new Center(
        child: _createStatusTable(configurations),
      ),
    ];
  }

  Widget _createStatusTable(Configuration configurations) {
    if (configurations == null) {
      return new Text('Server unreachable');
    }
    return Table(
        border: TableBorder.all(
            color: Colors.red[900], width: 1, style: BorderStyle.none),
        children: _createStatusCells(configurations));
  }

  List<TableCell> _prepareHeader() {
    final TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
    return [
      TableCell(
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Share", style: textStyle))),
      TableCell(child: Center(child: Text("Cart", style: textStyle))),
      TableCell(child: Center(child: Text("Date", style: textStyle)))
    ];
  }

  List<TableRow> _createStatusCells(Configuration info) {
    List<TableRow> rows = [];
    // prepare header
    rows.add(TableRow(children: _prepareHeader()));
    // prepare data

    rows.add(TableRow(children: [
      TableCell(
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(info.share.toString(), textAlign: TextAlign.left))),
      TableCell(
          child: Center(
              child: Text(info.cart.toString(), textAlign: TextAlign.left))),
      TableCell(
          child: Center(
              child: Text(info.date.toString(), textAlign: TextAlign.left)))
    ]));
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
