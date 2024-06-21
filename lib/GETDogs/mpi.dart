import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'mod.dart';

class mip extends StatefulWidget {
  const mip({super.key});

  @override
  State<mip> createState() => _mipState();
}

class _mipState extends State<mip> {

  Future<Dogs> fetch() async{
    var res = await http.get(Uri.parse("https://dog.ceo/api/breeds/image/random"));
    return Dogs.fromJson(jsonDecode(res.body));
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
                      Text(snapshot.data!.message.toString()),
                      Text(snapshot.data!.status.toString()),
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
