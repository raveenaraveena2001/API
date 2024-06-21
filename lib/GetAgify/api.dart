import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';
class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {

  Future<Agify> fetch() async{
    var res = await http.get(Uri.parse("https://api.agify.io?name=meelad"));
    return Agify.fromJson(jsonDecode(res.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context,snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.count.toString()),
                      Text(snapshot.data!.age.toString()),
                      Text(snapshot.data!.name.toString()),
                    ],
                  );
                }else if(snapshot.hasError){
                  return Text("error");
                }
                return CircularProgressIndicator();

              }
          )
        ],
      ),
    );
  }
}
