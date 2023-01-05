import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AddShed extends StatefulWidget {
  const AddShed({super.key});

  @override
  State<AddShed> createState() => _AddShedState();
}

class _AddShedState extends State<AddShed> {
  String API_URL = dotenv.get('API_URL', fallback: 'http://localhost:3000');

  var shedName = '';
  var username = 'tempName';
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  addNewShed(String owner, String shedName) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    print(shedName.toString() + "added and set owner to : " + owner.toString());
    var url = '$API_URL/api/shed/register';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, String>{'owner': owner, 'shedName': shedName}),
    );
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Shed'),
        backgroundColor: Colors.brown,
      ),
      body: Container(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          shedName = val;
                        });
                      },
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Shed Name',
                          labelText: 'Shed Name',
                          prefixIcon: Icon(Icons.local_gas_station_rounded)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      addNewShed(username, shedName);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.brown.shade600,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Center(
                        child: Text(
                          'Add',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
    });
  }
}
