import 'package:app_vendas_treino/pages/loginPage.dart';
import 'package:app_vendas_treino/services/router-service.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_vendas_treino/shared/sharedConstants.dart' as constants;
import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'medicoesPage.dart';

String authKey;
SharedPreferences preferences;

class HomePage extends StatefulWidget{
  static String tag = 'home-page';
  @override
  State<StatefulWidget> createState() => ListaScreen();
}

Future<String> _getNome() async {
  var prefs = await SharedPreferences.getInstance();
  var json = prefs.getString(constants.AuthKey);
  var itensJson = jsonDecode(json);
  return itensJson['nome'];
}

class ListaScreen extends State<HomePage>{

  Future<String> textoLido;

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
              child: FutureBuilder(
                future: _getNome(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    return Text('Olá ' + snapshot.data);
                  }
                  else{
                    return Text('Olá');
                  }
                }
              )
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text('Home'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    Navigator.of(context).push(RouterService.buildRoute(HomePage(), prefs));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.maximize),
                  title: Text('Medições'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    // Navigator.of(context).push(RouterService.buildRoute(Medicoes(), prefs));
                  },
                ),
                ListTile(
                  leading: Icon(Icons.crop_square),
                  title: Text('Produtos'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () async {
                    var prefs = await SharedPreferences.getInstance();
                    // Navigator.of(context).push(RouterService.buildRoute(Medicoes(), prefs));
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Sair'),
                      onTap: () async {
                        var prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        Navigator.of(context).push(RouterService.buildRoute(LoginPage(), prefs));
                      },
                    )
                  ) 
                )   
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.swap_horizontal_circle, color: Colors.white),
        onPressed: () async {
          //await startMeasure(context, "");
          setState(() async {
            var result = await BarcodeScanner.scan();
            await startMeasure(context, result);
          });
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
    .then((Consumer consumer) => consumer.listen((AmqpMessage message) async {
      var json = message.payloadAsJson;
      Navigator.pop(dialogContext);
      client.close();
      Fluttertoast.showToast(
          backgroundColor: Colors.green,
          msg: "Leitura realizado com sucesso!",
          toastLength: Toast.LENGTH_SHORT
        );
    }));
}