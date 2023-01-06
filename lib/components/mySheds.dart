import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fuel_app/components/widgets/navigationDrawerFuelOwner.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MySheds extends StatefulWidget {
  const MySheds({super.key});

  @override
  State<MySheds> createState() => _MyShedsState();
}

class _MyShedsState extends State<MySheds> {
  String API_URL = dotenv.get('API_URL', fallback: 'http://localhost:3000');
  var sheds = [];
  bool isShedsLoading = false;

  //-----fetching data

  @override
  void initState() {
    super.initState();
    print("running");
    fetchSheds();
  }

  fetchSheds() async {
    setState(() {
      isShedsLoading = true;
    });
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    var url = '$API_URL/api/shed/list';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print(response.statusCode);
    if (response.statusCode == 200) {
      final String? username = prefs.getString('username');
      var items = json.decode(response.body);
      setState(() {
        sheds = items.where((c) => c['owner'] == username).toList();
        isShedsLoading = false;
      });
    } else {
      setState(() {
        sheds = [];
        isShedsLoading = false;
      });
    }
  }

  updateShedAvailability(bool status, String shedId) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    // ignore: avoid_print
    print("$shedId changed to - $status");
    var url = '$API_URL/api/shed/$shedId';
    var response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, bool>{'availability': status}),
    );
    if (response.statusCode != 200) {
      updateShedAvailabilityDialog();
    }
  }

  //-----

  Widget getBody() {
    if (sheds.contains(null) || sheds.isEmpty || isShedsLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
        ),
      );
    }
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                color: Colors.blue.shade800,
                borderRadius: BorderRadius.circular(60 / 2)),
          ),
          SizedBox(width: 200, child: Text(shedName)),
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
      drawer: const NavigationDrawerFuelOwner(),
      appBar: AppBar(
        title: const Text("My Sheds"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      backgroundColor: Colors.brown.shade100,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: getBody(),
      ),
    );
  }

  Future<void> updateShedAvailabilityDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Failed to Update'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please try again'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
