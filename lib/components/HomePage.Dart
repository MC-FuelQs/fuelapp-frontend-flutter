// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fuel_app/components/stationPage.dart';
import 'package:fuel_app/components/feedPage.dart';
import 'package:fuel_app/components/widgets/navigationDrawerVehicleOwner.dart';
import 'package:animated_background/animated_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        drawer: NavigationDrawerVehicleOwner(),
        appBar: AppBar(
          title: const Text("Home Page"),
          backgroundColor: Colors.brown,
          centerTitle: true
        ),
        body: AnimatedBackground(
          behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 100,
            spawnMinSpeed: 4.00,
            particleCount: 10,
            spawnMaxSpeed: 20,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            baseColor: Colors.brown,
            
            ),
          ),
          vsync: this,
          child: Container(
            
          child: Column(            
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Feed()));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.brown,
                            spreadRadius: 1,
                            blurRadius: 8,
                            offset: Offset(4, 4),
                          ),
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(-4, -4),
                          )
                        ]),
                    child: const Center(
                      child: Text(
                        "Check all stations",
                        style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const StationPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      height: 100,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.brown,
                              spreadRadius: 1,
                              blurRadius: 8,
                              offset: Offset(4, 4),
                            ),
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(-4, -4),
                            )
                          ]),
                      child: const Center(
                        child: Text(
                          "Entered to a station",
                          style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          )
        )
        );
  }
}
