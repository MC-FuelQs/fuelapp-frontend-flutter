import 'package:flutter/material.dart';

class Feeds extends StatefulWidget {
  const Feeds({Key? key}) : super(key: key);

  @override
  State<Feeds> createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
                  color: Colors.purpleAccent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10,),
                  Icon(Icons.noise_aware),
                  SizedBox(width: 10,),
                  Text('Kurulegala IOC')
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
              children: [Text('10')],
            ),
          ),
          Container(
              color: Colors.pinkAccent,
              height: 70,
              width: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text('5')],
              )),
          Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
                  color: Colors.purpleAccent),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // children: [
                //   Icon(Icons.timelapse_outlined),
                //   Text('Waiting')],
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(Icons.car_repair),
                          Icon(Icons.fire_truck_sharp),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('2'),
                          Text('3')
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
