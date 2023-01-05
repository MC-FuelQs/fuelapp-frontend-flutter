import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

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

  String username = "";
  String password = "";

  String API_URL = dotenv.get('API_URL', fallback: 'http://localhost:3000');

  authenticateUser(
      String username, String password, String selectedUserType) async {
    print("Provided cerd : " + username.toString() + " " + password.toString());
    var url = '';
    if (selectedUserType == 'Filling Station Owner') {
      url = '$API_URL/api/shedown/login';
    } else if (selectedUserType == 'Vehical Owner') {
      url = '$API_URL/api/vehiown/login';
    } else {
      print('unknown user type');
    }

    var response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(
          <String, String>{'username': username, 'password': password}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var res_body = json.decode(response.body);
      print(res_body);
    } else {
      print("Failed login");
    }
  }

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
                  decoration: const InputDecoration(
                      labelText: "Vehical Type",
                      prefixIcon: Icon(Icons.supervised_user_circle)),
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
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        username = val;
                      });
                    },
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Your Username',
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person_rounded)),
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
                  child: TextField(
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter your Password',
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
                child: GestureDetector(
                  onTap: () {
                    authenticateUser(username, password, _selectedUserType);
                  },
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
