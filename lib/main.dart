import 'package:flutter/material.dart';

import 'pages/home.dart';

const request = "https://economia.awesomeapi.com.br/json/last/:moedas";

void main() async {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Home(),
        theme: ThemeData(
            hintColor: Colors.amber,
            primaryColor: Colors.white,
            inputDecorationTheme: const InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              hintStyle: TextStyle(color: Colors.amber),
            ))),
  );
}
