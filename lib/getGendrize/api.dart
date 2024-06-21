import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'mode.dart';
class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {

  Future<Genderize> fetch() async{
    var res = await http.get(Uri.parse("https://api.genderize.io?name=luc"));
    return Genderize.fromJson(jsonDecode(res.body));
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
                      Text(snapshot.data!.name.toString()),
                      Text(snapshot.data!.probability.toString()),
                      Text(snapshot.data!.gender.toString()),
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
