// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Ler os dois links sera de grande ajuda 
// https://medium.com/collabcode/flutter-construindo-uma-linda-aplica%C3%A7%C3%A3o-de-not%C3%ADcias-parte-1-f0cbeecb7ab
// https://medium.com/@rafaelbarbosatec/flutter-construindo-uma-linda-aplica%C3%A7%C3%A3o-de-not%C3%ADcias-parte-2-86586a18dae

import 'package:app_vendas_treino/pages/homePage.dart';
import 'package:app_vendas_treino/pages/medicoesPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/loginPage.dart';
import 'shared/sharedConstants.dart' as constants;

void main() async {
  runApp(new MyApp());
}

Future<bool> hasSession() async {
  var preferences = await SharedPreferences.getInstance();
  var key = preferences.getString(constants.LoginKey);
  return key.isNotEmpty && key != null;
}

class MyApp extends StatefulWidget {
  @override
  createState() => MyAppState();
}

class MyAppState extends State<MyApp>{
  Future<bool> _future = hasSession();

  initState() {
    super.initState();
    _future = hasSession();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder (
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        else{
          if(snapshot.data == true)
            return MaterialApp(home: HomePage());

          else
            return MaterialApp(home: LoginPage());
        }
    });
  }
}