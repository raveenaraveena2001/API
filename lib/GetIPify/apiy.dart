import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'modIp.dart';

class ipIfy extends StatefulWidget {
  const ipIfy({super.key});

  @override
  State<ipIfy> createState() => _ipIfyState();
}

class _ipIfyState extends State<ipIfy> {

  Future<IPify> fetch() async{
    var res = await http.get(Uri.parse("https://api.ipify.org?format=json"));
    return IPify.fromJson(jsonDecode(res.body));
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
                      Text(snapshot.data!.ip.toString()),
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
