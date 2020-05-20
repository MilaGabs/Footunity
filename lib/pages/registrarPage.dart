import 'package:app_vendas_treino/pages/loginPage.dart';
import 'package:flutter/material.dart';

class RegistrarPage extends StatefulWidget {
  RegistrarPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

enum SingingCharacter {feminino, masculino}

class _RegistrarPageState extends State<RegistrarPage>{

  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  DateTime _dataNascimento = DateTime.now();

  SingingCharacter _character = SingingCharacter.feminino;


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

  Widget _campo(String texto, TextEditingController controler,{bool senha = false}){
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
            height: 20,
          ),
          TextField(
            obscureText: senha,
            controller: controler,
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

  Widget _getSexo(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sexo: ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Feminino'),
              Radio(
                  value: SingingCharacter.feminino,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                Text('Masculino'),
                Radio(
                  value: SingingCharacter.masculino,
                  groupValue: _character,
                  onChanged: (SingingCharacter value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
            ],
          )
        ],
      ),
    );
  }

  Widget _getDataNascimento(){
    return Container( 
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Data de Nascimento',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)
          ),
          FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.calendar_today, color: Colors.purple),
                SizedBox(
                  width: 20,
                ),
                Text(_dataNascimento.day.toString()+'/'+_dataNascimento.month.toString()+'/'+_dataNascimento.year.toString()), 
              ]  
            ), 
            onPressed: (){
              showDatePicker(
                context: context, 
                initialDate: DateTime.now(), 
                firstDate: DateTime(1920), 
                lastDate: DateTime.now(),
              ).then((date){
                if (date != null && date != _dataNascimento) {
                  setState(() {
                    _dataNascimento = date;
                  });
                }
              });
            }  
          ),       
        ],
      ),
    );
  }

  Widget _getCampos(){
    return Column(
      children: <Widget>[
        _campo("Nome", nome),
        _getSexo(),
        _getDataNascimento(),
        _campo("E-mail", email),
        _campo("Senha", senha, senha: true),
      ],
    );
  }

  bool _validarRegistro(){
    if(nome.text==''){
      showDialog(
        context: context,
        barrierDismissible: true, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Preencha o campo nome para continuar.'),
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
    else if(email.text==''){
      showDialog(
        context: context,
        barrierDismissible: true, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Preencha o campo email para continuar.'),
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
    else if(senha.text==''){
      showDialog(
        context: context,
        barrierDismissible: true, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Preencha o campo senha para continuar.'),
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
        if (_validarRegistro() == true) {
          showDialog(
            context: context,
            barrierDismissible: true, 
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(nome.text+' '+email.text+' '+senha.text+' '+_character.index.toString()+' '+_dataNascimento.toString()),
              );
            },
          );
        }
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