import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:basispaysdk/basispaysdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic>? paymentRequestDictionary = {
      "orderId": "8273467924376",
      "amount": "6000",
      "currency": "INR",
      "description": "YYYYYY",
      "name": "XXXXXXX",
      "email": "XXXXXX",
      "phone": "ZZZZZZZZ",
      "addressLine1": "XXXXX",
      "addressLine2": "XXXXX",
      "city": "XXXXX",
      "state": "YYYYY",
      "country": "XXXXX",
      "zipCode": "YYYYY",
      "udf1": "udf1",
      "udf2": "udf2",
      "udf3": "udf3",
      "udf4": "Testing4",
      "udf5": "Testing5",
    };

    try {
      var response = Basispaysdk.startTransaction(
          "[API-KEY From Basispay team]",
          "[SALT-KEY From Basispay team]",
          "[YOUR- RETURN URL to get the response]",
          true,
          paymentRequestDictionary);
      response.then((value) {
        print(value);
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            print(onError.message! + " \n  " + onError.details.toString());
          });
        } else {
          setState(() {
            print(onError.toString());
          });
        }
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BasisPay example app'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      initPlatformState();
                    });
                  },
                  child: Text("Start webpage"))
            ],
          ),
        ),
      ),
    );
  }
}
