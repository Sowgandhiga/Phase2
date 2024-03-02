import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  String pickup = '';
  String destination = '';
  String finalResponse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(onPressed: logoutUser, icon: Icon(Icons.logout))
      ]),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Compare, Choose, Cruise',
                    style: TextStyle(
                      fontFamily: "inter",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Enter pickup location: '),
                    onChanged: (value) {
                      pickup = value;
                    },
                  ),
                  SizedBox(height: 40),
                  TextField(
                    decoration:
                        InputDecoration(labelText: 'Enter drop location: '),
                    onChanged: (value) {
                      destination = value;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      print(pickup);
                      print(destination);
                      finalResponse = "{ i love rideradar}";
                      print(finalResponse);
                    },
                    child: Text('Search'),
                  ),
                  SizedBox(height: 20),
                  TextField(
                      controller: TextEditingController(text: finalResponse),
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Cab Data',
                        border: OutlineInputBorder(),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Future<void> _getCabData() async {
//     final response = await getCabData(pickup, destination);
//     final responseData = jsonDecode(response);
//     setState(() {
//       if (responseData.containsKey('output')) {
//         finalResponse = responseData['output'];
//       } else {
//         finalResponse = 'No output received from the server.';
//       }
//     });
//   }

//   Future<String> getCabData(String pickup, String destination) async {
//     final response = await http.post(
//       Uri.parse('http://127.0.0.1:5000/'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'pickup': pickup,
//         'destination': destination,
//       }),
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load cab data');
//     }
//   }
