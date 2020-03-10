import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';


void main(){
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}


class MyApp extends StatefulWidget{
  @override
  _State createState() => new _State();
}

class _State extends State<MyApp> {
  double add=0;
  double sub=0;
  double mul=0;
  double div =0;

  String _value1 = '';
  String _value2 = '';

  void _onChange1(String value1){
    setState(() => _value1 = value1);
  }
  void _onChange2(String value2){
    setState(() => _value2 = value2);
  }

  void _onSubmit1(String value1) => setState(()=> _value1 = value1);
  void _onSubmit2(String value2) => setState(()=> _value2 = value2);

  void _onCalc(){
    setState(() {
      double i = double.parse(_value1);
      double j = double.parse(_value2 );
        add = i + j;
        sub = i - j;
        mul = i * j;
        div = i / j;
//        String storage = "add is " + add.toString() ;

    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Name Here'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(32.0),
          child: new Center(
            child: new Column(
              children: <Widget>[

                new TextField(
                    decoration: new InputDecoration(
                      labelText: 'first number',
                      icon: new Icon(Icons.people)
                    ),
                  autocorrect: true,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: _onChange1,
                  onSubmitted: _onSubmit1,
                ),

                new TextField(
                  decoration: new InputDecoration(
                    labelText: 'second number',
                    icon: new Icon(Icons.people)
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: _onChange2,
                  onSubmitted: _onSubmit2,
                ),

                new RaisedButton(onPressed: _onCalc, child: new Text('Calculate')),

                new Text('Addition =  ${add.toString()}',style: TextStyle(height: 2, fontSize: 26)),
                new Text('Subraction =  ${sub.toString()}',style: TextStyle(height: 2, fontSize: 26)),
                new Text('Multiplication =  ${mul.toString()}',style: TextStyle(height: 2, fontSize: 26)),
                new Text('Division = ${div.toString()}',style: TextStyle(height: 2, fontSize: 26)),
             ],
            ),
          )
      ),
    );
  }
}