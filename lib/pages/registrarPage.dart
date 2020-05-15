import 'package:app_vendas_treino/pages/loginPage.dart';
import 'package:flutter/material.dart';

class RegistrarPage extends StatefulWidget {
  RegistrarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage>{

  Widget _title(){
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Registrar-se',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
      ),    
    );
  }

  Widget _campo(String texto, {bool senha = false}){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            texto,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            obscureText: senha,
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: Color(0xfff3f3f4),
              filled: true
            )
          )
        ],
      ),
    );
  }

  Widget _getCampos(){
    return Column(
      children: <Widget>[
        _campo("Nome"),
        _campo("E-mail"),
        _campo("Senha", senha: true),
      ],
    );
  }

  Widget _getBtnConfirmar(){
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
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
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff8800ff), Color(0xff5d0dff)],
          ),
        ),
        child: Text(
          'Confirmar',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      onTap: (){
        
      },
    );
  }

  Widget _getJaTenhoConta(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Ja tem uma conta ? ',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
            child: Text(
              ' Login',
              style: TextStyle(
                color: Color(0xff5d0dff),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Footunity'),
        backgroundColor: Color(0xff5d0dff)
      ),
      body: _getPage(),
    );
  }

  Widget _getPage(){
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal:20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  _title(),
                  SizedBox(
                    height: 40,
                  ),
                  _getCampos(),
                  SizedBox(
                    height: 20,
                  ),
                  _getBtnConfirmar(),
                  SizedBox(
                    height: 20,
                  ),
                  _getJaTenhoConta(),
                  Expanded(
                    flex: 3,
                    child: SizedBox(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}