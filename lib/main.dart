import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:ocr/widget/text_area_widget.dart';
import 'package:clipboard/clipboard.dart';

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
        primarySwatch: Colors.deepOrange,
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
  String obtainedText='Result of scanning';

  @override
  void initState() {
    FlutterMobileVision.start().then((value) {
      _isInitialized=true;
    });
    super.initState();
  }

  _startScan() async{
    List <OcrText> tokens=List();
  obtainedText='';

    try {
      tokens=await FlutterMobileVision.read(
        multiple:  true,
        fps: 2,
      );
      for(OcrText text in tokens)
        {print("values are:${text.value}");
        setState(() {
          obtainedText+=text.value+'\n';
        });
        }
    }
    catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("app",style:TextStyle(color: Colors.deepOrange) ,),
        backgroundColor: Colors.white,),
      body:
           SingleChildScrollView(
             child: Column(
              children: [
                SizedBox(height: height*0.1,),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            shape: BoxShape.circle
                        ),
                        child:
                    IconButton(
                        icon:Icon(Icons.photo_camera,color: Colors.white,),
                        onPressed: _startScan)
                    ),
                    Text("press to scan"),
                  ],
                ),
                // RaisedButton(
                //   onPressed: _startScan,
                // child: Text("press"),),
                SizedBox(height: height*0.06,),
                TextAreaWidget(text:  obtainedText, onClickedCopy: copyToClipboard)
              ],
          ),
           ),


    );
  }
  void copyToClipboard() {
    if (obtainedText.trim() != '') {
       FlutterClipboard.copy(obtainedText);
     }
   }

}
