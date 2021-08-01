import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tipple_app/registry/registry-service.dart';
import 'package:tipple_app/registry/registry.dart';
import 'package:tipple_app/updateProfile/updateUserSettings-service.dart';

import '../menu-Items.dart';

class AddressPage extends StatefulWidget {
  final Future<Registry> registry;

  const AddressPage({Key key, this.registry}) : super(key: key);

  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController street = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController postCode = TextEditingController();
  TextEditingController city = TextEditingController();
  Registry _user;

  @override
  void initState() {
    _setValues();
  }

   _setValues() async {
    _user = await widget.registry;
    street.text = _user.address.street;
    houseNumber.text = _user.address.houseNumber;
    int code = _user.address.zipCode;
    postCode.text = (code == 0) ? '' : code.toString();
    city.text = _user.address.town;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Adresse Ergänzen',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: Color(0xFFFFFFFF),
            ),),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/background.png"),
            fit: BoxFit.cover,
          )),
          padding: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 16),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                  ),
                  _createField(street, 'Steindamm', 'Straße',
                      AutofillHints.streetAddressLevel1),
                  _createField(houseNumber, '20C', 'Hausenummer',
                      AutofillHints.streetAddressLevel2),
                  _createField(postCode, '12345', 'Postleitzeil',
                      AutofillHints.postalCode),
                  _createField(
                      city, 'Hamburg', 'Stadt', AutofillHints.addressCity),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 0, bottom: 16),
                    child: Container(
                      margin: const EdgeInsets.only(top: 120.0),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          _user.address.street = street.text;
                          _user.address.houseNumber = houseNumber.text;
                          int code;
                          try {
                            code = int.parse(postCode.text);
                          } catch (_) {
                            code = 0;
                          }
                          _user.address.zipCode = code;
                          _user.address.town = city.text;
                          await updateUser(buildMap(_user), _user.id);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                          );
                        },
                        child: Text(
                          "Submit",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFFFFFFF),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16.0),
                          primary: Color(0xFFFCC919),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _createField(TextEditingController controller, String hintText,
      String labelText, String autofillHints) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: (autofillHints.contains(AutofillHints.postalCode))
              ? TextInputType.number
              : null,
          controller: controller,
          autofocus: false,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(
                  width: 1,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Color(0xFFFFFFFF),
              // hintStyle: TextStyle(color: Color(0xFA111111)),
              hintStyle: TextStyle(color: Color(0x80000000)),
              hintText: hintText,
              labelText: labelText),
          autofillHints: [autofillHints],
        ),
      ),
    );
  }
}
