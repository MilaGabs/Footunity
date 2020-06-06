import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/sharedConstants.dart' as constants;

class Medicoes extends StatefulWidget { 
  @override
  MedicoesState createState() => MedicoesState();
}

Future<List> getData() async {
  var prefs = await SharedPreferences.getInstance();
  var reqHeader = { 
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + prefs.getString(constants.LoginKey),
      'Access-Control-Allow-Origin': '*'
  };
  var auth = prefs.getString(constants.AuthKey);
  var authJson = jsonDecode(auth);
  var url = constants.FootAPILink + "medicoes/obtermedicoes/" + authJson["id"].toString();
  var request = await http.get(url, headers: reqHeader);
  
  if(request.statusCode == 200){
    var body = request.body;
    List<dynamic> parsed = jsonDecode(body);
    return parsed;
  }
  else{
    return new List();
  }
}

class MedicoesState extends State<Medicoes> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(),
      builder: (context,  dataSnapshot) {
        if(dataSnapshot.connectionState == ConnectionState.done){
          return new Scaffold(
            appBar: new AppBar(
              title: new Text("Footunity - Medições"),
              backgroundColor: Color(0xff5d0dff),
            ),
            body: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return new ListTile(
                title: new Card(
                  elevation: 5.0,
                  child: new Container(
                    alignment: Alignment.center,
                    margin: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Text("Data: " + dataSnapshot.data[index]["dataHora"].toString())
                  ),
                ),
                onTap: () {
                  showDialog(
                    barrierDismissible: true,
                    context: context,
                    child: new AlertDialog(
                      title: new Column(
                        children: <Widget>[
                          new Text("Medição"),
                          new Row(),
                          new Icon(
                            Icons.transform,
                            color: Color(0xff5d0dff),
                          ),
                        ],
                      ),
                      content: new Container(
                        width: 75,
                        height: 130,
                        child: new Column(
                          children: <Widget>[
                            new Text("Centimetros: " + dataSnapshot.data[index]["centimetros"].toString()),
                            new Text("Inches: " + dataSnapshot.data[index]["inches"].toString()),
                            new Text("BR: " + dataSnapshot.data[index]["br"].toString()),
                            new Text("UK: " + dataSnapshot.data[index]["uk"].toString()),
                            new Text("EU: " + dataSnapshot.data[index]["eu"].toString()),
                            new Text("US: " + dataSnapshot.data[index]["us"].toString()),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start
                        ),
                      ),
                    )
                  );
                },
              );
            },
          ));
        }
        else 
          return Center(child: CircularProgressIndicator());
      }
    );
  }
}