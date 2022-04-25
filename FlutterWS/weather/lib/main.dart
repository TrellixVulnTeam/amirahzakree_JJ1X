import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWeatherPage(),
    );
  }
}

class MyWeatherPage extends StatefulWidget {
  const MyWeatherPage({Key? key}) : super(key: key);

  @override
  State<MyWeatherPage> createState() => _MyWeatherPageState();
}

class _MyWeatherPageState extends State<MyWeatherPage> {
  String selectLoc = "Changlun",
      description = "No weather information",
      weather = " ";
  double temperature = 0.0;
  double feelslike = 0.0;
  int humidity = 0;
  List<String> loclist = [
    "Changlun",
    "Jitra",
    "Alor Setar",
    "Baling",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Weather APP")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Simple Weather App",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            DropdownButton(
              itemHeight: 60,
              value: selectLoc,
              onChanged: (newValue) {
                setState(() {
                  selectLoc = newValue.toString();
                });
              },
              items: loclist.map((selectLoc) {
                return DropdownMenuItem(
                  child: Text(
                    selectLoc,
                  ),
                  value: selectLoc,
                );
              }).toList(),
            ),
            ElevatedButton(
                onPressed: _loadWeather, child: const Text("Load Wether")),
            const SizedBox(height: 10),
            Text(description,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          ],
        )));
  }

  Future<void> _loadWeather() async {
    var apiid = "331284eeb19643a5b66dfb666ed7a805";
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$selectLoc&appid=$apiid&units=metric');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      temperature = parsedData['main']['temp'];
      humidity = parsedData['main']['humidity'];
      weather = parsedData['weather'][0]['main'];
      feelslike = parsedData['main']['feels_like'];
      setState(() {
        description =
            "The current weather in $selectLoc is $weather." 
            "It feels like $feelslike."
            "The current temperature is $temperature Celcius and humidity is $humidity percent.";
      });
    }
  }
}
