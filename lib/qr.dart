import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_qr_bar_scanner/qr_bar_scanner_camera.dart';
// ignore: depend_on_referenced_packages

class qr extends StatefulWidget {
  @override
  _qrState createState() => _qrState();
}

  String selectedValue = 'Option 1';
  List<String> dropdownItems = ['Option 1', 'Option 2', 'Option 3'];

class _qrState extends State<qr> {
  String? _qrInfo = 'Scan a QR Code';
  bool camState = false;
  TextEditingController holectl = TextEditingController();
  // TextEditingController pass = TextEditingController();
    Future knit() async {
    var url = Uri.http("10.0.1.197",'/f/knit.php', {'q': '{http}'});
    var response = await http.post(url, body: {
      "hole": holectl.text.toString(),
      // "password": pass.text.toString(),
    });

  }
  qrCallback(String? code) {
    setState(() {
      camState = false;
      _qrInfo = code;
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      camState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (camState == true) {
            setState(() {
              camState = false;
            });
          } else {
            setState(() {
              camState = true;
            });
          }
        },
        child: Icon(Icons.camera),
      ),
      body: camState
          ? Container(
              child: SizedBox(
                height: 1000,
                width: 500,
                child: QRBarScannerCamera(
                  onError: (context, error) => Text(
                    error.toString(),
                    
                    style: TextStyle(color: Colors.red),
                  ),
                  qrCodeCallback: (code) {
                    qrCallback(code);
                  },
                ),
              ),
            )
          : Container(
            
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  
                  Center(
                    child: Text(
                      "Style ID :" + _qrInfo!,
                      style: TextStyle(
                        fontSize: 15,
                       fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline
                      ),
                    ),
                  ),
            //        Text(
            //   'Selected Hole:',
            //   style: TextStyle(fontSize: 18),
            //   textAlign: TextAlign.left,
            // ),
            // SizedBox(height: 10),
            // Text(
            //   selectedValue,
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            //   textAlign: TextAlign.left,
            // ),
            // SizedBox(height: 20),
            // DropdownButton<String>(
            //   value: selectedValue,
            //   onChanged: (newValue) {
            //     setState(() {
            //       selectedValue = newValue!;
            //     });
            //   },
            //   items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            // ),
           Container(
            alignment: Alignment.topLeft,
            
            
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              
              children: [
                  Text(
              'Selected H0le:',
              
              style: TextStyle(fontSize: 18),
              
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: SizedBox(height: 10,),
            ),
            Text(
              selectedValue,
              style: TextStyle(fontSize: 18,color: Colors.lightBlue),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 5,),
            
            DropdownButton<String>(
              value: selectedValue,
              isExpanded: true,
              onChanged: (holectl) {
                setState(() {
                  selectedValue = holectl!;
                });
              },
              items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value ,style: TextStyle(fontSize: 18,color: Colors.pinkAccent),),
                );
              }).toList(),
            ),
            GestureDetector(
                  onTap: () {
                    knit();
                  },
                  child: Container(
                    height: 53,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 4,
                              color: Colors.black12.withOpacity(.2),
                              offset: const Offset(2, 2))
                        ],
                        borderRadius: BorderRadius.circular(100)
                            .copyWith(bottomRight: const Radius.circular(0)),
                        gradient: LinearGradient(colors: [
                          Colors.purple.shade600,
                          Colors.amber.shade900
                        ])),
                    child: Text('Save',
                        style: TextStyle(
                            color: Colors.white.withOpacity(.8),
                            fontSize: 15,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
            ],)
            
           )     

              
            

                ],
              ),
              
            ),
    );
  }
}