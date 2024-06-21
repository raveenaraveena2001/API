import 'dart:convert';

import 'package:api/GETIpInfo/ipinfoModel.dart';
import 'package:api/GetIPify/apiy.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {

  Future<IpInfo> fetch() async{
    var res = await http.get(Uri.parse("https://ipinfo.io/161.185.160.93/geo"));
    return IpInfo.fromJson(jsonDecode(res.body));
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
                      Text(snapshot.data!.country.toString()),
                      Text(snapshot.data!.ip.toString()),
                      Text(snapshot.data!.loc.toString()),
                      Text(snapshot.data!.city.toString()),
                      Text(snapshot.data!.postal.toString()),
                      Text(snapshot.data!.readme.toString()),
                      Text(snapshot.data!.region.toString()),
                      Text(snapshot.data!.timezone.toString()),

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
