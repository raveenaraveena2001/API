import 'dart:convert';

import 'package:api/GETRandom/randommodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class getListApi extends StatefulWidget {
  const getListApi({super.key});

  @override
  State<getListApi> createState() => _getListApiState();
}

class _getListApiState extends State<getListApi> {

  Future<List<Results>> fetchdata() async {
    var res = await http.get(Uri.parse("https://datausa.io/api/data?drilldowns=Nation&measures=Population"));
    var data = jsonDecode(res.body)["data"];
    return (data as List).map((obj) => Results.fromJson(obj)).toList();
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
                  List<Results> list = snapshot.data!;
                  return Container(
                    height: 800,
                    child: ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, int index){
                          return ListTile(
                            leading: Text(list[index].id.toString()),
                            title: Column(
                              children: [
                                Text(list[index].login.toString()),
                                Text(list[index].gender.toString()),
                                Text(list[index].name.toString()),
                                Text(list[index].email.toString()),
                                Text(list[index].phone.toString()),
                                Text(list[index].cell.toString()),
                                Text(list[index].dob.toString()),
                                Text(list[index].location.toString()),
                                Text(list[index].nat.toString()),
                                Text(list[index].picture.toString()),
                                Text(list[index].registered.toString()),
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
