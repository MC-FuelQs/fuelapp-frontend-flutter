import 'package:flutter/material.dart';

class Feeds extends StatefulWidget {
  String shedName;
  int petrolVehicles;
  int dieselVehicles;
  int waitingtimePetrol;
  int waitingtimeDiesel;
  bool availability;

  Feeds({
    Key? key,
    required this.shedName,
    required this.petrolVehicles,
    required this.dieselVehicles,
    required this.waitingtimeDiesel,
    required this.waitingtimePetrol,
    required this.availability,
  }) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 80,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                  color: Colors.white),
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
                  Text(widget.shedName),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    child: widget.availability
                        ? Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.green.shade600,
                                borderRadius: BorderRadius.circular(60 / 2)),
                          )
                        : Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                color: Colors.red.shade600,
                                borderRadius: BorderRadius.circular(60 / 2)),
                          ),
                  )
                ],
              ),
            ),
          ),
          Container(
            color: Colors.yellowAccent.shade100,
            height: 80,
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Text('${widget.petrolVehicles}')],
            ),
          ),
          Container(
              color: Colors.orangeAccent.shade100,
              height: 80,
              width: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('${widget.dieselVehicles}')],
              )),
          Container(
              height: 80,
              width: 100,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.car_repair),
                          Text('${widget.waitingtimePetrol} min')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.fire_truck_sharp),
                          Text('${widget.waitingtimeDiesel} min')
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
