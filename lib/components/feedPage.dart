import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fuel_app/components/widgets/feedHeader.dart';
import 'package:fuel_app/components/widgets/feeds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // ignore: non_constant_identifier_names
  String API_URL = dotenv.get('API_URL', fallback: 'http://localhost:3000');
  List sheds = [];
  List feed = [];
  bool isLoadingData = false;

  @override
  void initState() {
    super.initState();
    // ignore: avoid_print
    print('fetching...');
    fetchSheds();
  }

  fetchSheds() async {
    isLoadingData = true;
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');
    var url = '$API_URL/api/shed/list';
    var response = await http.get(Uri.parse(url), headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    print('shed status : ${response.statusCode}');
    if (response.statusCode == 200) {
      var items = json.decode(response.body);
      sheds = items;
      var url = '$API_URL/api/feed/list';
      var response_feed = await http.get(Uri.parse(url), headers: {
        HttpHeaders.contentTypeHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $token"
      });
      print('Feed status : ${response_feed.statusCode}');
      if (response_feed.statusCode == 200) {
        var items_feed = json.decode(response_feed.body);
        setState(() {
          feed = items_feed;
          // print(feed);

          sheds.asMap().forEach((index, shed) {
            int countVehiclePetrol = 0;
            int countAllVehiclePetrol = 0;
            int countVehicleDiesel = 0;
            int countAllVehicleDiesel = 0;
            int fullWaitingTimePetrol = 0;
            int fullWaitingTimeDiesel = 0;
            feed.asMap().forEach((index, feed) {
              if (feed['shedName'] == shed['_id'] &&
                  feed['type'] == 'Petrol' &&
                  feed['isWaiting']) {
                countVehiclePetrol++;
                countAllVehiclePetrol++;
                int currentTime = DateTime.now().millisecondsSinceEpoch;
                int arrivalTime = feed['arrivalTime'];
                int waitingTime = currentTime - arrivalTime;
                fullWaitingTimePetrol += fullWaitingTimePetrol + waitingTime;
              }
              if (feed['shedName'] == shed['_id'] &&
                  feed['type'] == 'Petrol' &&
                  !feed['isWaiting']) {
                countAllVehiclePetrol++;
                int arrivalTime = feed['arrivalTime'];
                int leftTime = feed['departTime'];
                int waitingTime = leftTime - arrivalTime;
                fullWaitingTimePetrol += fullWaitingTimePetrol + waitingTime;
              }
              if (feed['shedName'] == shed['_id'] &&
                  feed['type'] == 'Diesel' &&
                  feed['isWaiting']) {
                countVehicleDiesel++;
                countAllVehicleDiesel++;
                int currentTime = DateTime.now().millisecondsSinceEpoch;
                int arrivalTime = feed['arrivalTime'];
                int waitingTime = currentTime - arrivalTime;
                fullWaitingTimeDiesel += fullWaitingTimeDiesel + waitingTime;
              }
              if (feed['shedName'] == shed['_id'] &&
                  feed['type'] == 'Diesel' &&
                  !feed['isWaiting']) {
                countAllVehicleDiesel++;
                int arrivalTime = feed['arrivalTime'];
                int leftTime = feed['departTime'];
                int waitingTime = leftTime - arrivalTime;
                fullWaitingTimeDiesel += fullWaitingTimeDiesel + waitingTime;
              }
            });
            double AWTPetrol = 0;
            if (countAllVehiclePetrol != 0) {
              AWTPetrol = fullWaitingTimePetrol / countAllVehiclePetrol;
            } else {}
            double AWTDiesel = 0;
            if (countAllVehicleDiesel != 0) {
              AWTDiesel = fullWaitingTimeDiesel / countAllVehicleDiesel;
            } else {}
            sheds[index]['averageWaitingTimePetrol'] =
                (AWTPetrol / 60000).toInt();
            sheds[index]['averageWaitingTimeDiesel'] =
                (AWTDiesel / 60000).toInt();
            sheds[index]['petrolVehicleCount'] = countVehicleDiesel;
            sheds[index]['dieselVehicleCount'] = countVehiclePetrol;
          });
          isLoadingData = false;
        });
      } else {
        setState(() {
          feed = [];
          isLoadingData = false;
        });
      }
    } else {
      setState(() {
        sheds = [];
        isLoadingData = false;
      });
    }
  }

  Widget getBody() {
    if (isLoadingData) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.brown),
        ),
      );
    }
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: sheds.length,
        itemBuilder: (context, index) {
          return Feeds(
              shedName: sheds[index]['shedName'],
              petrolVehicles: sheds[index]['petrolVehicleCount'],
              dieselVehicles: sheds[index]['dieselVehicleCount'],
              waitingtimeDiesel: sheds[index]['averageWaitingTimeDiesel'],
              waitingtimePetrol: sheds[index]['averageWaitingTimePetrol'],
              availability: sheds[index]['availability']);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shed Details"),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      backgroundColor: Colors.brown.shade100,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: <Widget>[const FeedHeader(), getBody()],
        ),
      ),
    );
  }
}
