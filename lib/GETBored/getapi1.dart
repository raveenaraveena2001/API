import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../GETApi/getmodal.dart';
import 'getmodel1.dart';
class getapi extends StatefulWidget {
  const getapi({super.key});

  @override
  State<getapi> createState() => _getapiState();
}

class _getapiState extends State<getapi> {

  Future<Bored> fetch() async {
    var result = await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
    return Bored.fromJson(jsonDecode(result.body));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetch(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.type.toString()),
                      Text(snapshot.data!.price.toString()),
                    ],
                  );
                } else if(snapshot.hasError){
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
