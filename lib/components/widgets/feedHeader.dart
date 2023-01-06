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
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(20)),
                color: Colors.purpleAccent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  width: 10,
                ),
                Icon(Icons.warehouse_outlined),
                SizedBox(
                  width: 10,
                ),
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
            children: const [Icon(Icons.car_repair), Text('Petorl')],
          ),
        ),
        Container(
            color: Colors.pinkAccent,
            height: 70,
            width: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [Icon(Icons.fire_truck_sharp), Text('Desel')],
            )),
        Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(20)),
                color: Colors.purpleAccent),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [Icon(Icons.timelapse_outlined), Text('Waiting')],
            ))
      ],
    );
  }
}
