import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MySheds extends StatefulWidget {
  const MySheds({super.key});

  @override
  State<MySheds> createState() => _MyShedsState();
}

class _MyShedsState extends State<MySheds> {
  var sheds = [];
  bool isShedsLoading = true;

  //-----fetching data

  @override
  void initState() {
    super.initState();
    print("running");
    fetchSheds();
  }

  fetchSheds() async {
    var url = 'https://jsonplaceholder.typicode.com/users';
    var response = await http.get(Uri.parse(url));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        sheds = items;
      });
    } else {
      setState(() {
        sheds = [];
      });
    }
  }
  //-----

  bool _state = false;

  Widget getBody() {
    return ListView.builder(
        itemCount: sheds.length,
        itemBuilder: (context, index) {
          return getCard(sheds[index]);
        });
  }

  Widget getCard(item) {
    var shedName = item['name'];
    return Card(
      child: ListTile(
          title: Row(
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.amber.shade800,
                borderRadius: BorderRadius.circular(60 / 2)),
          ),
          Text(shedName),
          Switch(
            onChanged: (bool s) {
              setState(() {
                print(s);
                _state = s;
              });
            },
            value: _state,
            activeColor: Colors.black,
            activeTrackColor: Colors.green,
            inactiveTrackColor: Colors.deepOrange,
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Sheds"),
        backgroundColor: Colors.brown,
      ),
      backgroundColor: Colors.brown.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: getBody(),
      ),
    );
  }
}