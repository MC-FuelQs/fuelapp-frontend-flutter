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
  String _selectedStation = "";
  String _selectedVehicleType = "Petrol";
  List vehicalTypes = ["Petrol", "Diesel"];
  int joinedTime = 0;
  int leftTime = 0;
  bool joinedToQueue = false;
  bool leftQueue = false;
  bool isFilled = false;
  String feedId = '';

  @override
  void initState() {
    super.initState();
    print("fetching....");
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
      setState(() {
        sheds = data;
        _selectedStation = data[0]['_id'];
      });
    });
  }

  joinQueue(String selectedStation, String selectedVehicleType,
      int joinedTime) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    var url = '$API_URL/api/feed/setfeed';
    var response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'shedName': selectedStation,
        'type': selectedVehicleType,
        'arrivalTime': joinedTime.toString()
      }),
    );
    // ignore: avoid_print
    print('Joined Q status: ${response.statusCode}');
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      feedId = res['_id'];
    }
  }

  leaveQueue(String feedId, int leftTime, bool isFilled) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    var url = '$API_URL/api/feed/$feedId';
    var response = await http.put(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      },
      body: jsonEncode(<String, String>{
        'departTime': leftTime.toString(),
        'isFilled': isFilled.toString(),
      }),
    );
    // ignore: avoid_print
    print('left Q status: ${response.statusCode}');
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Station"),
          backgroundColor: Colors.brown.shade600,
          leading: Icon(Icons.local_gas_station_outlined),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.brown.shade200,
          padding: const EdgeInsets.all(30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField<String>(
                hint: const Text('Select a Station'),
                value: _selectedStation,
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
                    _selectedStation = newValue.toString();
                  });
                },
                icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                    color: Colors.brown),
                dropdownColor: Colors.brown,
                decoration: const InputDecoration(
                  labelText: "Select a Station",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField<String>(
                hint: const Text('Select your vehical type'),
                value: _selectedVehicleType,
                items: vehicalTypes.map((item) {
                  return new DropdownMenuItem(
                    value: item.toString(),
                    child: new Text(
                      item,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedVehicleType = newValue.toString();
                  });
                },
                icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                    color: Colors.brown),
                dropdownColor: Colors.brown,
                decoration: const InputDecoration(
                  labelText: "Select Vehical Type",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: !joinedToQueue
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: GestureDetector(
                        onTap: () {
                          joinedTime = DateTime.now().millisecondsSinceEpoch;
                          setState(() {
                            joinedToQueue = true;
                          });
                          joinQueue(_selectedStation, _selectedVehicleType,
                              joinedTime);
                          print("Joined to queue");
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                              color: Colors.green.shade800,
                              borderRadius: BorderRadius.circular(12)),
                          child: const Center(
                            child: Text(
                              'Join the queue',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.brown.shade200,
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
            Container(
              child: !leftQueue && joinedToQueue
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                leftQueue = true;
                                leftTime =
                                    DateTime.now().millisecondsSinceEpoch;
                                leaveQueue(feedId, leftTime, isFilled);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.red.shade800,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Exit Before Pump',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.sentiment_dissatisfied_outlined,
                                    color: Colors.white,
                                  )
                                ],
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
                              setState(() {
                                leftQueue = true;
                                isFilled = true;
                                leftTime =
                                    DateTime.now().millisecondsSinceEpoch;
                                leaveQueue(feedId, leftTime, isFilled);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.green.shade800,
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text(
                                    'Exit After Pump',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.sentiment_satisfied_alt_outlined,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: joinedToQueue
                          ? Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.brown.shade200,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Text(
                                  'Left the Queue',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.all(20.0),
                              decoration: BoxDecoration(
                                  color: Colors.brown.shade200,
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Center(
                                child: Text(
                                  'Join before leave',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                    ),
            ),
            Container(
              padding: const EdgeInsets.all(25.0),
              child: !joinedToQueue || leftQueue
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade600,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            'Back To Home',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            )
          ]),
        ));
  }
}
