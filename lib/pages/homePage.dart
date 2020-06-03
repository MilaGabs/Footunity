import 'package:dart_amqp/dart_amqp.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vendas_treino/shared/sharedConstants.dart' as constants;
import 'package:http/http.dart' as http;

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
        onPressed: () async {
          await startMeasure(context, "");
          /*setState(() async {
            var result = await BarcodeScanner.scan();
            await startMeasure(context, result);
          });*/
        },
        backgroundColor: Color(0xff5d0dff),
      ),
      body: Center(child: Text('Bem vindo ao FootUnity'),),
    );
  }
}

startMeasure(context, macAdrress) async {
  var prefs = await SharedPreferences.getInstance();
  var authData = prefs.getString(constants.AuthKey);
  var auth = jsonDecode(authData);

  var connectionSettings = new ConnectionSettings(
    host: constants.RabbitMQHost,
    port: constants.RabbitMQPort,
    authProvider: constants.RabbitMQAuth,
    virtualHost: '/'
  );

  Client client = Client(settings: connectionSettings);

  var jsonPost = 
  { 
    "MacAddress": macAdrress,
    "UserId": auth['id'],
  };
  BuildContext dialogContext;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      dialogContext = context;
        return AlertDialog(
          content: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Center(
                child: new SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: new CircularProgressIndicator(
                    value: null,
                    strokeWidth: 7.0,
                  ),
                ),
              ),
              new Container(
                margin: const EdgeInsets.only(top: 25.0),
                child: new Center(
                  child: new Text(
                    "Aguardando medição...",
                    style: new TextStyle(
                      color: Color(0xff5d0dff)
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
    }
  );

  http.post(constants.FootAPILink + 'message/startmeasure', body: jsonPost);

  client
    .channel()
    .then((Channel channel) => channel.queue("ReturnMeasure"))
    .then((Queue queue) => queue.consume())
    .then((Consumer consumer) => consumer.listen((AmqpMessage message) {
      var json = message.payloadAsJson;
      Navigator.pop(dialogContext);
      client.close();
    }));
}