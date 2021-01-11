// import 'dart:html';
import 'dart:convert';
import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
// 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  title: "json via http",
  theme: new ThemeData(
    primarySwatch: Colors.teal,
  ),
  home: new HomePage(),
),
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final String url = 'http://api.openweathermap.org/geo/1.0/direct?q=London&limit=5&appid=ae4230f5032cc131f1f957ab67ddb981';
  List data;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.get(
      Uri.encodeFull(url),
      headers:{"Accept":"Application/json"}
    );
    
    print(response.body);
    setState(() {
          var covertDataToJson = json.decode(response.body);
          data = covertDataToJson['London'];
        });
        
      return "Success";
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Get Json By http"),
      ),
      body: new ListView.builder(
        itemCount:   data == null?0:data.length,
        itemBuilder: (BuildContext context,int index){
          return new Container(
            child: new Center(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  new Card(
                    child: new Container(
                      child: new Text(data[index]['ar']),
                      padding: const EdgeInsets.all(20.0),
                    )
                  )
                ],
              ),
            ),
          );
        },
      ),
      
    );
  }
}