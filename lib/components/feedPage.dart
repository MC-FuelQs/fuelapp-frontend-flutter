import 'package:flutter/material.dart';
import 'package:fuel_app/components/widgets/feedHeader.dart';
import 'package:fuel_app/components/widgets/feeds.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text('Shed Details'),
        backgroundColor: Colors.brown,
        centerTitle: true,
        // leading: Icon(Icons.store_outlined)
      ),
      body: Column(
        children: [
          const FeedHeader(),
          const SizedBox(
            height: 5,
          ),
          Feeds(
              shedName: 'Name',
              petrolVehicles: 6,
              dieselVehicles: 7,
              waitingtimeDiesel: 6,
              waitingtimePetrol: 7),
          Feeds(
              shedName: 'Name',
              petrolVehicles: 6,
              dieselVehicles: 7,
              waitingtimeDiesel: 6,
              waitingtimePetrol: 7),
          Feeds(
              shedName: 'Name',
              petrolVehicles: 6,
              dieselVehicles: 7,
              waitingtimeDiesel: 6,
              waitingtimePetrol: 7),
        ],
      ),
    );
  }
}
