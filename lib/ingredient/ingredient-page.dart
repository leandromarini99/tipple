import 'package:flutter/material.dart';
import 'ingredient.dart';

class IngredientPage extends StatelessWidget {
  IngredientPage({Key key, this.title, this.ingredients}) : super(key: key);


  final String title;
  final Future<List<Ingredient>> ingredients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
            child: FutureBuilder<List<Ingredient>>(
                future: this.ingredients,
                builder: (context, snapshot)  {
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

  Widget _buildGridView(BuildContext context, List<Ingredient> ingredients) {
    return GridView.count(
      primary: false,
      padding: const EdgeInsets.all(1.5),
      crossAxisCount: determineCrossAxisCount(context),
      childAspectRatio: 1.2,
      mainAxisSpacing: 1.0,
      crossAxisSpacing: 1.0,
      children: _prepareServerInfoCards(ingredients), //new Cards()
      shrinkWrap: true,
    );
  }

  List<Widget> _prepareServerInfoCards(List<Ingredient> ingredients) {
    List<Widget> serverInfoCells = [];
    // we can call the rest service here?
    for (Ingredient ingredient in ingredients) {
      serverInfoCells.add(_getServerInfoCard(ingredient));
    }

    return serverInfoCells;
  }

  Container _getServerInfoCard(Ingredient ingredient) {
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
              children: _prepareStatusText(ingredient)),
        ));
  }

  List<Widget> _prepareStatusText(Ingredient ingredient) {
    final TextStyle textStyle =
        TextStyle(fontWeight: FontWeight.bold, height: 3);
    return <Widget>[
      new Center(
        child: new Text(ingredient.id, style: textStyle),
      ),
      new Center(
        child: _createStatusTable(ingredient),
      ),
    ];
  }

  Widget _createStatusTable(Ingredient ingredient) {

    if (ingredient==null) {
      return new Text('Server unreachable');
    }
    return Table(
        border: TableBorder.all(
            color: Colors.red[900], width: 1, style: BorderStyle.none),
        children: _createStatusCells(ingredient));
  }

  List<TableCell> _prepareHeader() {
    final TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
    return [
      TableCell(
          child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text("Name", style: textStyle))),
      TableCell(child: Center(child: Text("Url", style: textStyle))),
      TableCell(child: Center(child: Text("Price", style: textStyle)))
    ];
  }

  List<TableRow> _createStatusCells(Ingredient info) {
    List<TableRow> rows = [];
    // prepare header
    rows.add(TableRow(children: _prepareHeader()));
    // prepare data
  
      rows.add(TableRow(children: [
        TableCell(
            child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(info.name, textAlign: TextAlign.left))),
        TableCell(
        child: Center(
        child: Text(info.url, textAlign: TextAlign.left))),
        TableCell(
            child: Center(
                child: Text(info.price.toString(),
                    textAlign: TextAlign.left)))
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
