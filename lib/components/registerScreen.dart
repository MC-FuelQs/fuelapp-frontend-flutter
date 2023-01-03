import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  _RegisterScreenState() {
    _selectedVehicalType = _VehicalType[0];
    _selectedUserType = _UserType[0];
  }
  // ignore: non_constant_identifier_names
  final _VehicalType = ['Petrol', 'Desel'];
  String _selectedVehicalType = "";

  final _UserType = ['Vehical Owner', 'Filling Station Owner'];
  String _selectedUserType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown.shade200,
        body: SafeArea(
          child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // welcome back
              const Icon(
                Icons.directions_car_filled,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Register",
                style: GoogleFonts.bebasNeue(
                  fontSize: 40,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Save hours of waiting in queues!",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField(
                  value: _selectedUserType,
                  items: _UserType.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedUserType = val as String;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                      color: Colors.brown),
                  dropdownColor: Colors.brown[50],
                  decoration: const InputDecoration(
                    labelText: "Vehical Type",
                    prefixIcon: Icon(Icons.supervised_user_circle),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // Name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.verified_user),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // vehical type
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: DropdownButtonFormField(
                  value: _selectedVehicalType,
                  items: _VehicalType.map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      )).toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedVehicalType = val as String;
                    });
                  },
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined,
                      color: Colors.brown),
                  dropdownColor: Colors.brown[50],
                  decoration: const InputDecoration(
                    labelText: "Vehical Type",
                    prefixIcon: Icon(Icons.car_crash_rounded),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              //username
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: const TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter a unique Username',
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person_rounded),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              //password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(12)),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.password_rounded),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              // signin button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                      color: Colors.brown.shade600,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  Text(
                    ' Sign in',
                    style: TextStyle(color: Colors.blue.shade600),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
