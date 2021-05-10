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
    Map<String, dynamic> paymentRequestDictionary = {
      "orderId": "8349574023489",
      "amount": "6000",
      "currency": "INR",
      "description": "Book Fuel",
      "name": "Naveen",
      "email": "nvnkumar398@gmail.com",
      "phone": "8248350384",
      "addressLine1": "no 28/39",
      "addressLine2": "no 28/39",
      "city": "Chennai",
      "state": "TamilNadu",
      "country": "India",
      "zipCode": "600014",
      "udf1": "udf1",
      "udf2": "udf2",
      "udf3": "udf3",
      "udf4": "Testing4",
      "udf5": "Testing5",
    };
    try {
      var response = Basispaysdk.startTransaction(
          "79e111fb-098d-4730-8c3a-17fe0c30738a",
          "69ecafcf78912a3f57a00f0e78ea4194efcd7d24",
          "http://167.71.235.104:8080/cinchfuel/order/pgreturn",
          true,
          paymentRequestDictionary,
          false);
      response.then((value) {
        print(value);
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            print(onError.message + " \n  " + onError.details.toString());
          });
        } else {
          setState(() {
            print(onError.toString());
          });
        }
      });
    } catch (err) {
      print(err.message);
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
