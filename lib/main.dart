// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_is_empty, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _namecontroller = TextEditingController();
  var result;

  predictGender(String name) async {
    var url = Uri.parse("https://api.genderize.io/?name=$name");
    var res = await http.get(url);
    var body = jsonDecode(res.body);
    result = "Gender:${body['gender']},Probability:${body['probability']}";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gender Prediction"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Text("Enter a name to predict its gender"),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _namecontroller,
                decoration: InputDecoration(hintText: "Enter Name"),
              ),
            ),
            ElevatedButton(
                onPressed: () => predictGender(_namecontroller.text),
                child: Text("Predict")),
            if (result != null) Text(result)
          ],
        ),
      ),
    );
  }
}
