import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState() {
    _selectedUserType = _UserType[0];
  }

  // ignore: non_constant_identifier_names
  final _UserType = ['Vehical Owner', 'Filling Station Owner'];
  String _selectedUserType = "";

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
                size: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Login",
                style: GoogleFonts.bebasNeue(
                  fontSize: 52,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome back user!",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),

              const SizedBox(
                height: 50,
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
                  decoration: const InputDecoration(labelText: "Vehical Type"),
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
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter Your Username',
                          labelText: 'Username'),
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
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your Password',
                        labelText: 'Password',
                      ),
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
                      'Sign In',
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
                  const Text('Not a member?'),
                  Text(
                    ' Register',
                    style: TextStyle(color: Colors.blue.shade600),
                  ),
                ],
              )
            ]),
          ),
        ));
  }
}
