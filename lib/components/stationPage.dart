import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'HomePage.dart';

class StationPage extends StatefulWidget {
  const StationPage({super.key});

  @override
  State<StationPage> createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  _StationPageState() {
    _selectStation = _fuelStation[0];
  }

  final _fuelStation = ['Kandy', 'Colombo', 'Kurunegala'];
  String _selectStation = "";

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Station"),
          backgroundColor: Colors.brown.shade600,
        ),
        body: Container(
          color: Colors.brown.shade200,
          padding: EdgeInsets.all(30),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: DropdownButtonFormField(
                value: _selectStation,
                items: _fuelStation
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _selectStation = val as String;
                  });
                },
                icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                    color: Colors.brown),
                dropdownColor: Colors.brown,
                decoration: const InputDecoration(
                  labelText: "Select Station",
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.brown.shade600,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.brown.shade600,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text(
                      'Exit Before Pump',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const HomePage();
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.brown.shade600,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text(
                      'Exit After Pump',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
  }
}
