import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test_project/random_api.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int randomNumber = 0;
  List<int> prevNumbers = [];

  getRandom () async {
    int _randomNumber = await RandomApi.fetchRandom();
    setState((){
      randomNumber = _randomNumber;
      prevNumbers.add(randomNumber);
    });
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
          backgroundColor: Colors.green,
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                    onPressed: getRandom,
                    child: Text("Get A New Random Number"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                ),
              ),

              Text('$randomNumber',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                )
              ),

              SizedBox(height: 40),

              Text('Previous Numbers',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                  )
              ),

              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: prevNumbers.length,
                  itemBuilder: (BuildContext ctxt, int index){
                    return Center(child: Text('${prevNumbers[index]}'));
                  }
              )

            ],
          )
        ),
        ),
      );
  }
}