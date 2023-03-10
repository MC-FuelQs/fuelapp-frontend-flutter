import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fuel_app/components/homePage.dart';
import 'package:fuel_app/components/mySheds.dart';
import 'package:fuel_app/components/registerScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  storeUserName(String username) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', username);
    print('Username stored in SharedPrefs');
  }

  storeUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('authToken', token);
    print('User token stored in SharedPrefs');
  }

  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();

    final String? token = prefs.getString('authToken');
    return token;
  }

  authenticateUser(
      String username, String password, String selectedUserType) async {
    print("Provided cerd : " + username.toString() + " " + password.toString());
    var url = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (selectedUserType == 'Filling Station Owner') {
      url = '$API_URL/api/shedown/login';
    } else if (selectedUserType == 'Vehical Owner') {
      url = '$API_URL/api/vehiown/login';
    } else {
      print('unknown user type');
    }

    final response = await http.post(
      Uri.parse(url),
      headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode(
          <String, String>{'userName': username, 'password': password}),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var res_body = json.decode(response.body);
      storeUserToken(res_body['token']);
      storeUserName(username);
      final savedToken = getUserToken();
      if (selectedUserType == 'Filling Station Owner') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const MySheds()));
      } else if (selectedUserType == 'Vehical Owner') {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } else {
      print("Failed login");
      loginFailedDialog();
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown.shade200,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          authenticateUser(
                              username, password, _selectedUserType);
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
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: Text(
                            ' Register',
                            style: TextStyle(color: Colors.blue.shade600),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }

  Future<void> loginFailedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please check your credentials'),
                Text('Or Register'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
