import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  final String? text;
  final BuildContext? context;
  CustomAppBar(this.text, this.context)
      : super(
            backgroundColor: Colors.blueGrey[900],
            title: Text(
              text!,
              style: TextStyle(
                  fontSize: text.length > 25 ? 18 : 25, color: Colors.white),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.of(context!).pop();
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                )));
}
