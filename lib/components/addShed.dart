import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddShed extends StatefulWidget {
  const AddShed({super.key});

  @override
  State<AddShed> createState() => _AddShedState();
}

class _AddShedState extends State<AddShed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Shed'),
        backgroundColor: Colors.brown,
      ),
    );
  }
}
