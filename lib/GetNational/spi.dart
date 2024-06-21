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

  Future<Country> fetch() async{
    var res = await http.get(Uri.parse("https://api.nationalize.io?name=nathaniel"));
    return Country.fromJson(jsonDecode(res.body));
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
                      Text(snapshot.data!.countryId.toString()),
                      Text(snapshot.data!.probability.toString()),

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
