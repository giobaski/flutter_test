import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


Future<Random> fetchRandom() async {
  final response = await http.get(Uri.parse('csrng.net/csrng/csrng.php?min=1&max=1000'));

  // var jsondata = jsonDecode(response.body);
  // print(jsondata);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Random.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load random');
  }


  // final response = await http.get(Uri.https('csrng.net', '/csrng/csrng.php'));

  print('dsdsds');
}


class Random {
  final int random;

  Random({
    required this.random,
  });

  factory Random.fromJson(Map<String, dynamic> json) {
    return Random(
      random: json['random']
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Random> futureRandom;


  @override
  void initState() {
    super.initState();
    futureRandom = fetchRandom();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Random Numbers'),
        ),
        body: Center(
          child: FutureBuilder<Random>(
            future: futureRandom,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.random.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
        ),
      ),
    );
  }
}