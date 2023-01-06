import 'package:flutter/material.dart';

class FeedHeader extends StatelessWidget {
  const FeedHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            height: 70,
            color: Colors.brown.shade500,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.warehouse_outlined, color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Fuel Station',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                )
              ],
            ),
          ),
        ),
        Container(
          color: Colors.yellowAccent.shade100,
          height: 70,
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.car_repair),
              Text('Petorl' , style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Queue', style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ),
        ),
        Container(
            color: Colors.orangeAccent.shade100,
            height: 70,
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.fire_truck_sharp),
                Text('Desel', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Queue', style: TextStyle(fontWeight: FontWeight.bold))
              ],
            )),
        Container(
            height: 70,
            width: 100,
            color: Colors.brown.shade500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.timelapse_outlined, color: Colors.white),
                Text('Waiting', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                Text('Time', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
              ],
            ))
      ],
    );
  }
}
