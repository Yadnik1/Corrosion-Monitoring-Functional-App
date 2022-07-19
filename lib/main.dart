// main.dart
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'api_call.dart';
import 'my-globals.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((value) => runApp(MyApp()));
  runApp(const MyApp());
}

List<double>? getData() {
  Stream<List<double>> finalData = getDataFromWifi();
  finalData.listen((List<double> Data1) {
    datalist = Data1;
  });
  return datalist;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Data from Device',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // final spots = <FlSpot>[];
  List<FlSpot> globallist = [];
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      // while(true){

      // }
      setState(() {
        globallist = getData()!
            .asMap()
            .entries
            .map((it) => FlSpot(it.key.toDouble(), it.value.toDouble()))
            .toList();
      });
    });
  }
  // data(getData) {
  //   setState(() {
  //     getData();
  //   });

  //   super.initState();
  //   const oneSecond = Duration(seconds: 25);
  //   Timer.periodic(oneSecond, (Timer t) => data);
  // }

  // var spots = getData()!
  //     .asMap()
  //     .entries
  //     .map((it) => FlSpot(it.key.toDouble(), it.value.toDouble()))
  //     .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              lineBarsData: [
                plotline(globallist)
                // The red line
                // LineChartBarData(
                //   spots: spots,
                //   isCurved: true,
                //   barWidth: 3,
                //   colors: [
                //     Colors.red,
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  LineChartBarData plotline(List<FlSpot> points) {
    return LineChartBarData(
      spots: points,
      isCurved: true,
      barWidth: 3,
      colors: [
        Colors.blue,
      ],
    );
    // globallist = getData()!
    //     .asMap()
    //     .entries
    //     .map((it) => FlSpot(it.key.toDouble(), it.value.toDouble()))
    //     .toList();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
