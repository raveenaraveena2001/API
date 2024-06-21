import 'dart:convert';

import 'package:api/GETZippop/zippopmodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ZippopApi extends StatefulWidget {
  const ZippopApi({super.key});

  @override
  State<ZippopApi> createState() => _ZippopApiState();
}

class _ZippopApiState extends State<ZippopApi> {

  Future<List<Places>> fetchdata() async {
    var res = await http.get(Uri.parse("https://api.zippopotam.us/us/33162"));
    var data = jsonDecode(res.body)["data"];
    return (data as List).map((obj) => Places.fromJson(obj)).toList();
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
                  List<Places> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, int index){
                          return ListTile(
                            leading: Text(list[index].latitude.toString()),
                            title: Column(
                              children: [
                                Text(list[index].longitude.toString()),
                                Text(list[index].placeName.toString()),
                                Text(list[index].state.toString()),
                                Text(list[index].stateAbbreviation.toString()),
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
