import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/Configurator/common-buttons.dart';
import 'package:tipple_app/configuration/configuration.dart';

class EditConfigPage extends StatelessWidget {
  final Configuration config;

  const EditConfigPage({Key key, this.config}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFCC919),
        title: Text(
          'Konfiguration Bearbeiten',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/background.png"),
          fit: BoxFit.cover,
        )),
        child: _ConfigList(config: config,),
      ),
    );
  }
}

class _ConfigList extends StatefulWidget {
  final Configuration config;

  const _ConfigList({Key key, this.config}) : super(key: key);

  @override
  _ConfigListState createState() => _ConfigListState();
}

class _ConfigListState extends State<_ConfigList> {
  int state = 0;

  update() {
    setState(() {
      state = -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    var itemNameStyle = Theme.of(context).textTheme.headline6;
    return Column(children: [
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(32),
              child: ListView.builder(
                itemCount: widget.config.ingredient.length,
                itemBuilder: (context, index) => ListTile(
                  // leading: Image.asset('${ingredients[index].url.replaceAll('www.tipple.com/', '')}.png'),
                  leading: Image.asset(
                    "assets/" +
                        widget.config.ingredient[index].name.toLowerCase() +
                        ".png",
                    width: 50,
                    height: 50,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (widget.config.ingredient.length > 1) {
                        widget.config.ingredient
                            .remove(widget.config.ingredient[index]);
                        // Navigator.of(context).pop();
                        update();
                      }
                    },
                  ),
                  title: Text(
                    widget.config.ingredient[index].name,
                    style: itemNameStyle,
                  ),
                ),
              ))),
      Divider(height: 4, color: Colors.black),
      CartControls(
       title: 'cartControls', config: widget.config, totalPrice: widget.config.ingredient.length * 1.5,
      )
    ]);
  }
}


