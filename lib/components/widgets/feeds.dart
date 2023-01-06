import 'package:flutter/material.dart';

class Feeds extends StatefulWidget {
  String shedName;
  int petrolVehicles;
  int dieselVehicles;
  int waitingtimePetrol;
  int waitingtimeDiesel;

  Feeds(
      {Key? key,
      required this.shedName,
      required this.petrolVehicles,
      required this.dieselVehicles,
      required this.waitingtimeDiesel,
      required this.waitingtimePetrol})
      : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              height: 70,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.purpleAccent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(Icons.noise_aware),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.shedName)
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
              children: [Text('${widget.petrolVehicles}')],
            ),
          ),
          Container(
              color: Colors.pinkAccent,
              height: 70,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('${widget.dieselVehicles}')],
              )),
          Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.purpleAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          Icon(Icons.car_repair),
                          Icon(Icons.fire_truck_sharp),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('${widget.waitingtimePetrol}'),
                          Text('${widget.waitingtimeDiesel}')
                        ],
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}
