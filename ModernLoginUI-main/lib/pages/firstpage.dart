// import 'package:flutter/material.dart';
// import 'package:modernlogintute/pages/loginreg.dart';
// import 'login_page.dart';

// class FirstPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(colors: [
//               const Color.fromARGB(255, 60, 20, 74),
//               const Color.fromARGB(255, 95, 65, 103)
//             ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'lib/images/logo.png',
//                   width: 200,
//                   height: 200,
//                 ),
//                 SizedBox(height: 30),
//                 Text(
//                   'Compare, Choose, Cruise',
//                   style: TextStyle(
//                     fontFamily: "inter",
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginReg()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 192, 192, 192)),
//                   child: Text('Get Started',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CabCompare extends StatefulWidget {
  const CabCompare({Key? key}) : super(key: key);

  @override
  _CabCompareState createState() => _CabCompareState();
}

class _CabCompareState extends State<CabCompare> {
  String pickup = '';
  String destination = '';
  String finalResponse = '';

  Future<void> _getCabData() async {
    final response = await getCabData(pickup, destination);
    setState(() {
      finalResponse = response;
    });
  }

  Future<String> getCabData(String pickup, String destination) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'pickup': pickup,
        'destination': destination,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cab data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cab Compare'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter pickup location: '),
              onChanged: (value) {
                setState(() {
                  pickup = value;
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(labelText: 'Enter drop location: '),
              onChanged: (value) {
                setState(() {
                  destination = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _getCabData();
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Text(finalResponse),
          ],
        ),
      ),
    );
  }
}
