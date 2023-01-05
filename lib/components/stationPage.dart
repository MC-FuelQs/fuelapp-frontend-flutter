// ignore_for_file: unnecessary_new

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class StationPage extends StatefulWidget {
  const StationPage({super.key});

  @override
  State<StationPage> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  String API_URL = dotenv.get('API_URL', fallback: 'http://localhost:3000');
  List sheds = [];
  // List testData = [
  //   {
  //     "_id": "63b46a5c39685b64f63018d7",
  //     "owner": "123123123",
  //     "shedName": "colombo ST",
  //     "availability": true,
  //   },
  //   {
  //     "_id": "63b5eafc3eba4a67d7ec5696",
  //     "owner": "madawa",
  //     "shedName": "Kandy ST",
  //     "availability": false,
  //   },
  //   {
  //     "_id": "63b5eb273eba4a67d7ec5698",
  //     "owner": "madawa",
  //     "shedName": "Gohagoda ST",
  //     "availability": false,
  //   },
  // ];
  bool isShedsLoading = false;
  String _selectStation = "63b46a5c39685b64f63018d7";

  @override
  void initState() {
    super.initState();
    print("running");
    _fetchSheds();
  }

  _fetchSheds() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    var url = '$API_URL/api/shed/list';
    await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    }).then((response) {
      print(response.statusCode);
      var data = json.decode(response.body);
      print(data);
      setState(() {
        sheds = data;
        _selectStation = data[0]['_id'];
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Station"),
          backgroundColor: Colors.brown.shade600,
        ),
        body: Container(
          color: Colors.brown.shade200,
          padding: const EdgeInsets.all(30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: !isShedsLoading
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: DropdownButtonFormField<String>(
                            hint: const Text('Select a Station'),
                            value: _selectStation,
                            items: sheds.map((item) {
                              return new DropdownMenuItem(
                                value: item['_id'].toString(),
                                child: new Text(
                                  item['shedName'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                _selectStation = newValue.toString();
                              });
                            },
                            icon: const Icon(
                                Icons.arrow_drop_down_circle_outlined,
                                color: Colors.brown),
                            dropdownColor: Colors.brown,
                            decoration: const InputDecoration(
                              labelText: "Select a Station",
                            ),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.brown.shade600,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Joined',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.brown.shade600,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Exit Before Pump',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.brown.shade600,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Exit After Pump',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        ));
  }
}
