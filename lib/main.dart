import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'dart:async';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Title',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isInitialized=false;

  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      _isInitialized=true;
    });
    super.initState();
  }

  _startScan() async{
    List <OcrText> tokens=List();

    try {
      tokens=await FlutterMobileVision.read(
        multiple:  true,
        fps: 2,
      );
      for(OcrText text in tokens)
        print("values are:${text.value}");
    }
    catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app",)),
      body: Center(
        child: Column(
          children: [
            Text("press to scan"),
            RaisedButton(onPressed: _startScan,
            child: Text("press"),)
          ],
        ),
      ),
    );
  }
}
