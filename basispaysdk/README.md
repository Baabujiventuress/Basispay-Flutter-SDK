
# BasisPay-Flutter-KIT
A Flutter plugin to use the BasisPay Payment gateway kit for accepting online payments in Flutter app.


## INTRODUCTION
This document describes the steps for integrating Basispay online payment gateway Flutter SDK kit.This payment gateway performs the online payment transactions with less user effort. It receives the payment details as input and handles the payment flow. Finally returns the payment response to the user. User has to import the framework manually into their project for using it

## Requirements
o iOS 11.0+
o Xcode 11.0+ 
o Swift 5.0+
o Android min SDK - 21

## First of all get Credentials from BasisPay
Plugin will only work with API Keys 

# BasisPay-Flutter-KIT
A Flutter plugin to use the BasisPay Payment gateway kit for accepting online payments in Flutter app.


## INTRODUCTION
This document describes the steps for integrating Basispay online payment gateway Flutter SDK kit.This payment gateway performs the online payment transactions with less user effort. It receives the payment details as input and handles the payment flow. Finally returns the payment response to the user. User has to import the framework manually into their project for using it

## Requirements
o iOS 11.0+
o Xcode 11.0+ 
o Swift 5.0+
o Android min SDK - 21

## First of all get Credentials from BasisPay
Plugin will only work with API Keys 

##ANDROID
STEP 1:
Go to your android folder in your app and go into build.gradle file
```
  allprojects {
  		repositories {
  			...
  			maven { url 'https://jitpack.io' }
  		}
  	}
  ``` 
STEP 2:
Go to your android/app/src/main/res/values and android/app/src/main/res/values-night create a file named colors.xml in both folder
```
  <?xml version="1.0" encoding="utf-8"?>
  <resources>
      <color name="colorPrimary">#3F51B5</color>
      <color name="colorPrimaryDark">#303F9F</color>
      <color name="colorAccent">#FF4081</color>
  </resources>
  ``` 
## Start Payment
```
  Future<void> initPlatformState() async {
      Map<String, dynamic> paymentRequestDictionary = {
        "orderId": "8349574023489",
              "amount": "6000",
              "currency": "INR",
              "description": "YYYYYY",
              "name": "XXXXXXX",
              "email": "YYYYYYY",
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
           to check  true,
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
  
  ``` 

## Author

BasisPay, basispay@gmail.com

## License

BasisPay is available under the MIT license. See the LICENSE file for more info.
