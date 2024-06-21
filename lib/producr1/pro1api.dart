import 'dart:convert';

import 'package:api/producr1/pro1model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class pro2 extends StatefulWidget {
  final int id;

  const pro2({super.key,required this.id});

  @override
  State<pro2> createState() => _pro2State();
}

class _pro2State extends State<pro2> {

  Future<Product1> fetch() async{
    int id = widget.id;
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products/$id"));
    return Product1.fromJson(jsonDecode(res.body));
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
                      Text(widget.id.toString()),
                      Text(snapshot.data!.title.toString()),
                      //Text(snapshot.data!.id.toString()),
                      Text(snapshot.data!.rating.toString()),
                      Text(snapshot.data!.category.toString()),
                      Text(snapshot.data!.description.toString()),
                      Text(snapshot.data!.price.toString()),
                      Image.network(snapshot.data!.image.toString()),
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
