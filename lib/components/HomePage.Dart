// ignore: file_names
import 'package:flutter/material.dart';
import 'package:fuel_app/components/stationPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          backgroundColor: Colors.brown,
        ),
        body: Container(
          color: Colors.grey.shade300,
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Center(
                
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const StationPage()));
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
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const StationPage()));
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
        ));
  }
}
