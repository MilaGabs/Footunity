import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vendas_treino/shared/sharedConstants.dart' as constants;

import 'dart:convert';

String authKey;
SharedPreferences preferences;

class HomePage extends StatefulWidget{
  static String tag = 'home-page';
  @override
  State<StatefulWidget> createState() => ListaScreen();
}

class ListaScreen extends State<HomePage>{
  Stream<SharedPreferences> _prefs = (() async* {
    yield prefs = await SharedPreferences.getInstance();
  })();

  Future<String> textoLido;
  static SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Footunity"),
        backgroundColor: Color(0xff5d0dff),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: StreamBuilder<SharedPreferences>(
                stream: _prefs,
                builder: (context, snapshot) {
                  switch(snapshot.connectionState){
                    case ConnectionState.done:
                      prefs = snapshot.data;
                      var json = prefs.getString(constants.AuthKey);
                      var object = jsonDecode(json);
                      Text('Olá ' + object[2]);
                      break;
                    case ConnectionState.none:
                      Text('Olá');
                      break;
                    case ConnectionState.waiting:
                      Text('Olá');
                      break;
                    case ConnectionState.active:
                      Text('Olá');
                      break;
                  }
                }
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.swap_horizontal_circle, color: Colors.white),
        onPressed: () {
          setState(() async {
            var result = await BarcodeScanner.scan();

            print(result);
          });
        },
        backgroundColor: Color(0xff5d0dff),
      ),
      body: Center(child: Text('Bem vindo ao FootUnity'),),
    );
  }
}