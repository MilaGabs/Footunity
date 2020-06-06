import 'dart:convert';

import 'package:app_vendas_treino/pages/homePage.dart';
import 'package:app_vendas_treino/services/router-service.dart';

import 'registrarPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import '../shared/sharedConstants.dart' as constants;


class LoginPage extends StatefulWidget{
  static String tag = 'login-page';
  final state = new _LoginState();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {

  final email = TextEditingController();
  final senha = TextEditingController();

  @override
  void dispose(){
    email.dispose();
    senha.dispose();
    // super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: _getContainer(),
      ),
    );
  }

  Widget _getTextField(String title, TextEditingController controler,{bool senha = false}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: senha,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true
            ),
            controller: controler,
          )
        ],
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'F',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: 'oo',
            style: TextStyle(color: Color(0xff5d0dff), fontSize: 30),
          ),
          TextSpan(
            text: 'tunity',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
        ]
      ),    
    );
  }

  bool _verificarLogin(){
    if (email.text == ''){
      showDialog(
        context: context,
        barrierDismissible: true, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campo email vazio.'),
             actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
      return false;
    }
    else if(senha.text == ''){
      showDialog(
        context: context,
        barrierDismissible: true, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Campo senha vazio.'),
             actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
      return false;
    }
    else{
      return true;
    }
  }

  Widget _getBtnEntrar() {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.shade200,
              offset: Offset(2, 4),
              blurRadius: 5,
              spreadRadius: 2
            )
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff8800ff), Color(0xff5d0dff)]
          )
        ),
        child: Text(
          'Entrar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: () async {
        if(_verificarLogin()) {
          var user = new LoginModel(email.text, senha.text);
          var body = json.encode(user);
          try{
            var response = await http.post(constants.AuthAPILink + '/generatetoken', body: body, headers: { "content-type": "application/json; charset=utf-8"});
            if(response.statusCode == 200) {
              var retorno = json.decode(response.body);
              var preferences = await SharedPreferences.getInstance();
              preferences.setString(constants.LoginKey, retorno['token'].toString());
              preferences.setString(constants.AuthKey, json.encode(retorno['auth']));
              await toast.Fluttertoast.showToast(
                    backgroundColor: Colors.green,
                    msg: "Login realizado com sucesso!",
                    toastLength: Toast.LENGTH_SHORT
                  );
              Navigator.push(context, RouterService.buildRoute(HomePage(), preferences));
            }
            else{
              throw new Exception();
            }
          }
          catch(value) {
            retornarDialog(context, 'Ocorreu um erro ao realizar login. Verifique seu usuário e senha');
          }
        }
      }  
    );
  }

  Widget _getBtnRegistrar(){ 
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Ainda não tem uma conta ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 20,
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                context, MaterialPageRoute(builder: (context) => RegistrarPage()));
            },
            child: Text(
              'Registrar',
              style: TextStyle(
                color: Color(0xff5d0dff),
                fontSize: 13,
                fontWeight: FontWeight.w600
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _getContainer(){
    return new SingleChildScrollView( 
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(          
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   _title(),
                   SizedBox(
                     height: 80,
                   ),
                  _getTextField('Email: ', email),
                  _getTextField('Senha: ', senha,senha: true),
                  SizedBox(
                    height: 30,
                  ),
                  _getBtnEntrar(),  
                  SizedBox(
                    height: 30,
                  ),
                  _getBtnRegistrar(), 
                ],
              ),
            ),        
          ],
        ) 
      ),
    );  
  }

} 


class LoginModel {
  final String email;
  final String password;

  LoginModel(this.email, this.password);

  toJson() {
    return {
      'Email': email,
      'Password': password
    };
  }
}

retornarDialog(context, texto){
  showDialog(
      context: context,
      barrierDismissible: true, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(texto),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
  );
}