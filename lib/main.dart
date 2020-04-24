// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Ler os dois links sera de grande ajuda 
// https://medium.com/collabcode/flutter-construindo-uma-linda-aplica%C3%A7%C3%A3o-de-not%C3%ADcias-parte-1-f0cbeecb7ab
// https://medium.com/@rafaelbarbosatec/flutter-construindo-uma-linda-aplica%C3%A7%C3%A3o-de-not%C3%ADcias-parte-2-86586a18dae

import 'package:app_vendas_treino/pages/itemsPage.dart';
import 'package:app_vendas_treino/pages/qrCode.dart';
import 'package:flutter/material.dart';

import 'pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Primeiro App',
       home: HomePage(),
       routes: <String, WidgetBuilder> {
         '/QrCode' : (BuildContext context) => QrCode(),
         '/Items' : (BuildContext context) => ItemsPage(),
        //  '/Produtos' : (BuildContext context) => produtoPage();
        //  '/Login' : (BuildContext context) => loginPage()
       }
    );
  }
}