import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

RichText greet() {
  return RichText(
    text: TextSpan(
      text: 'Moin!',
      style: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: Color(0xFF000000),
      ),
    ),
  );
}

RichText displayMsg(String msg) {
  return RichText(
    text: TextSpan(
      text: msg,
      style: GoogleFonts.poppins(
        fontSize: 16,
        color: Color(0xFF000000),
      ),
    ),
  );
}

TextField createTextField(
    TextEditingController controller, bool obscureText, String hintText) {
  return TextField(
    style: GoogleFonts.poppins(
      fontSize: 14,
      color: Color(0x80000000),
    ),
    textAlign: TextAlign.center,
    controller: controller,
    showCursor: true,
    obscureText: obscureText,
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
      hintStyle: TextStyle(color: Color(0x80000000)),
      hintText: hintText,
    ),
  );
}

Flexible createFlexible(TextEditingController controller, String hintText) {
  return Flexible(
    flex: 1,
    child: TextField(
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: Color(0x80000000),
      ),
      textAlign: TextAlign.center,
      controller: controller,
      showCursor: true,
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
        hintStyle: TextStyle(
          color: Color(0x80000000),
        ),
        hintText: hintText,
      ),
    ),
  );
}

Flexible createRowWithNavigator(
    String msg, BuildContext context, MaterialPageRoute route, String title) {
  return Flexible(
    flex: 1,
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text(
              msg + ' ',
              // "Du hast schon einen Account? ",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Color(0xFF000000),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, route);
            },
            child: Container(
              child: Text(
                // "Login",
                title,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F6C9C),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
