import 'package:flutter/material.dart';

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
          title: Text('Shed Details'),
          backgroundColor: Colors.brown,
          centerTitle: true,
          leading: Icon(Icons.store_outlined)),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(20)),
                      color: Colors.purpleAccent),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.warehouse_outlined),
                      Text('Fuel Station')
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.blueAccent,
                height: 70,
                width: 70,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [Icon(Icons.car_repair), Text('Petorl')],
                ),
              ),
              Container(
                  color: Colors.pinkAccent,
                  height: 70,
                  width: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Icon(Icons.fire_truck_sharp), Text('Desel')],
                  )),
              Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20)),
                      color: Colors.purpleAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [Icon(Icons.timelapse_outlined), Text('Waiting')],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
