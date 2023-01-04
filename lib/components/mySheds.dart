import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class MySheds extends StatefulWidget {
  const MySheds({super.key});

  @override
  State<MySheds> createState() => _MyShedsState();
}

class _MyShedsState extends State<MySheds> {
  // ----- temp
  String token = dotenv.get('jwttoken',
      fallback:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzaGVkT3duZXJJZCI6IjYzYjVlOWZiM2ViYTRhNjdkN2VjNTY4ZiIsImlhdCI6MTY3Mjg2NjM1OSwiZXhwIjoxNjcyOTUyNzU5fQ.-IWQrFNIGY4Zo-qxYpIUsKj6z6Lw4KvEH-b43XuzHzQ');

  String API_URL = dotenv.get('API_URL', fallback: 'http://localhost:3000');
  String username = "madawa";
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
    var url = '$API_URL/api/shed/list';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      setState(() {
        sheds = items.where((c) => c['owner'] == username).toList();
      });
    } else {
      setState(() {
        sheds = [];
      });
    }
  }

  updateShedAvailability(bool status, String shedId) async {
    print(shedId.toString() + " changed to - " + status.toString());
    var url = '$API_URL/api/shed/$shedId';
    var response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, bool>{'availability': status}),
    );
  }
  //-----

  Widget getBody() {
    return ListView.builder(
        itemCount: sheds.length,
        itemBuilder: (context, index) {
          return getCard(sheds[index], index);
        });
  }

  Widget getCard(item, index) {
    var shedName = item['shedName'];
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
            onChanged: (bool status) {
              setState(() {
                updateShedAvailability(status, sheds[index]['_id']);
                sheds[index]['availability'] = status;
              });
            },
            value: sheds[index]['availability'],
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
