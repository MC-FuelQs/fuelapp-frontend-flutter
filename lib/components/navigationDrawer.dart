import 'package:flutter/material.dart';
import 'package:fuel_app/components/addShed.dart';
import 'package:fuel_app/components/mySheds.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  var username = 'tempName';
  @override
  void initState() {
    super.initState();
    getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeader(context),
          buildMenuItems(context),
        ],
      )),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      color: Colors.brown.shade200,
      child: Column(
        children: [
          const CircleAvatar(
            radius: 52,
            backgroundImage:
                NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            username,
            style: TextStyle(color: Colors.brown.shade900, fontSize: 24),
          ),
          Text(
            'Shed Owner',
            style: TextStyle(color: Colors.brown.shade600, fontSize: 16),
          ),
          const SizedBox(
            height: 24,
          )
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text("Home"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const MySheds()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text("Add New Shed"),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const AddShed()));
              },
            ),
            const Divider(
              color: Colors.brown,
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded),
              title: const Text("Logout"),
              onTap: () {},
            )
          ],
        ),
      );

  getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username').toString();
    });
  }
}
