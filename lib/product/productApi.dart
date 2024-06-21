import 'dart:convert';
import 'package:api/producr1/pro1api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ProductModel.dart';

class pro extends StatefulWidget {
  const pro({super.key});

  @override
  State<pro> createState() => _proState();
}

class _proState extends State<pro> {

  Future<List<Product>> fetchdata() async {
    var res = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(res.body);
    return (data as List).map((obj) => Product.fromJson(obj)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: fetchdata(),
                builder: (BuildContext context, snapshot){
                  if(snapshot.hasData){
                    List<Product> list = snapshot.data!;
                    return Container(
                      height: 900,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: (context, int index){
                            return GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => pro2(id:list[index].id!)),
                                );
                              },
                              child: ListTile(
                                leading: Text(list[index].category.toString()),
                                title: Column(
                                  children: [
                                    Text(list[index].description.toString()),
                                    Text(list[index].rating.toString()),
                                    Image.network(list[index].image.toString()),
                                  ],
                                ),
                              ),
                            );
                          }
                      ),
                    );
                  }
                  else if (snapshot.hasError)
                  {
                    return Text("${snapshot.error}");
                  }
                  return CircularProgressIndicator();
                }
                )
          ],
        ),
      ),
    );
  }
}
