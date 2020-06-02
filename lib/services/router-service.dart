import 'package:app_vendas_treino/pages/loginPage.dart';
import 'package:flutter/material.dart';
import '../shared/sharedConstants.dart' as Constants;

class RouterService {
  static MaterialPageRoute buildRoute(Widget route, prefs) {
    if(prefs.getString(Constants.AuthKey) != null)
      return new MaterialPageRoute(
        builder: (ctx) => route,
      );
    else
      return new MaterialPageRoute(
        builder: (ctx) => LoginPage(),
      );
  }
}