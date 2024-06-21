import 'dart:convert';

import 'package:api/GETUniversity/uniModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UniApi extends StatefulWidget {
  const UniApi({super.key});

  @override
  State<UniApi> createState() => _UniApiState();
}

class _UniApiState extends State<UniApi> {

  Future<List<University>> fetchdata() async {
    var res = await http.get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    var data = jsonDecode(res.body)["data"];
    return (data as List).map((obj) => University.fromJson(obj)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FutureBuilder(
              future: fetchdata(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  List<University> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, int index){
                          return ListTile(
                            leading: Text(list[index].name.toString()),
                            title: Column(
                              children: [
                                Text(list[index].country.toString()),
                                Text(list[index].domains.toString()),
                                Text(list[index].alphaTwoCode.toString()),
                              ],
                            ),
                          );
                        }
                    ),
                  );
                } else if (snapshot.hasError){
                  return Text("error");
                } return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}
