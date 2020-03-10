import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Save Operation value to Phone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(
        storage: Storage(),
      ),
    );
  }
}

//void main(){
//  runApp(new MaterialApp(
//    home: new Home(
//      storage: Storage(),
//    ),
//  ));
//}

class Home extends StatefulWidget{
  final Storage storage;
  Home({ Key key, @required this.storage}) :super(key: key);

  @override
  _State createState() => new _State();
}

class _State extends State<Home> {

  String state= '';
  String content;
  Future<Directory> _appDocDir;

  double add=0;
  double sub=0;
  double mul=0;
  double div =0;
  String _value1 = '';
  String _value2 = '';

  void _onSubmit1(String value1) => setState(()=> _value1 = value1);
  void _onSubmit2(String value2) => setState(()=> _value2 = value2);

//  void _onCalc(){
//    setState(() {
//      double i = double.parse(_value1);
//      double j = double.parse(_value2 );
//        add = i + j;
//        sub = i - j;
//        mul = i * j;
//        div = i / j;
//
//        state = "Addition is = ${add.toString()} \n subtraction is = ${sub.toString()}";
//
//    });
//  }

  @override
  void initState(){
    super.initState();
    widget.storage.readData().then( (String value){
    setState(() {
      state = value;
    });
    });
  }


  Future<File> writeData() async {
    setState(() {
      // calculate and write data
      double i = double.parse(_value1);
      double j = double.parse(_value2 );
      add = i + j;
      sub = i - j;
      mul = i * j;
      div = i / j;

      state = "Addition is = ${add.toString()} \nsubtraction is = ${sub.toString()}\n"+
          "Multiplication is =${mul.toString()} \n Divition is ${div.toString()}";

    });
    return widget.storage.writeData(state);
  }

 void getAppDir(){
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
 }

 void readData(){
    setState(() {
      content = state;
    });
 }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('00 Calculator 00'),
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
                  onSubmitted: _onSubmit1,
                ),

                new TextField(
                  decoration: new InputDecoration(
                    labelText: 'second number',
                    icon: new Icon(Icons.people)
                  ),
                  keyboardType: TextInputType.number,
                  onSubmitted: _onSubmit2,
                ),

//                new RaisedButton(onPressed: _onCalc, child: new Text('Calculate')),

                new RaisedButton(
                  onPressed: writeData,
                  child: Text('write to file')
                ),
                
                new RaisedButton(
                  onPressed: getAppDir,
                  child: new Text('get app Dir')
                ),

                FutureBuilder<Directory>(
                  future: _appDocDir,
                  builder:
                      (BuildContext context, AsyncSnapshot<Directory> snapshot){
                    Text text = Text('');
                    if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError){
                          text= Text('Error: ${snapshot.error}');
                        }else if(snapshot.hasData){
                          text = Text('path ${snapshot.data.path}');
                        }else{
                          text= Text('Unavailable');
                        }
                    }
                    return new Container(
                      child: text,
                    );
                  },
                ),

                new RaisedButton(
                  onPressed: readData,
                  child: Text('read from file')
                ),

                new Text('${content ?? "File is empty"}'),

              ],
            ),
          )
      ),
    );
  }
}
class Storage{
  Future<String> get localPath async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();
      return body;
    } catch(e){
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString("$data");

  }




}