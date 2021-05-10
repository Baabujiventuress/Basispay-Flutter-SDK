# basispaysdk

A new Flutter plugin.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# BasisPay-Flutter-KIT
BasisPay Flutter Payment Gateway kit for developers


## INTRODUCTION
This document describes the steps for integrating Basispay online payment gateway Flutter SDK kit.This payment gateway performs the online payment transactions with less user effort. It receives the payment details as input and handles the payment flow. Finally returns the payment response to the user. User has to import the framework manually into their project for using it
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
o iOS 11.0+
o Xcode 11.0+ 
o Swift 5.0+

## Installation

BasisPay is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BasisPay' , '~> 1.0.0'
```

## Step 1
Initialize your  PaymentGateway controller by importing Basispay in your project

```
import BasisPay

class PaymentProcessViewController: UIViewController {
    
    var paymentGatewayViewController: PaymentGatewayController!
    var amount:String?
    var titleValue:String?
    var descriptionValue:String?
    @IBOutlet weak var viewContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentGatewayViewController = PaymentGatewayController()
        viewContainer.addSubview(paymentGatewayViewController.view)
       setDefaults()
         setInputDictionary()
         checkAndGetResponse()
     }
```
## Step 2
Assign the Payment defaults in your class which you have already recieved from the Basispay organization.

```
private func setDefaults() {
      paymentGatewayViewController.paymentDefaults = PaymentDefaults(apiKey: "", saltKey: "", returnUrl: "", endPoint: .Testing) }    

```

## Step 3
Pass the mandatory details regarding the product which you are going to use the payment gateway in your app.

```
private func setInputDictionary() {
    guard let amountVal = amount,let titleVal = titleValue,let descriptionVal = descriptionValue else {
        return
    }
    
    let paymentRequestDictionary: NSDictionary = [
        "orderId" : "253698",
        "amount" : amountVal,
        "currency" : "INR",
        "description" : descriptionVal,
        "name" : titleVal,
        "email" : "qwerty@123gmail.com",
        "phone" : "5876986087",
        "addressLine1" : "address_line_1",
        "addressLine2" : "address_line_2",
        "city" : "city",
        "state" : "state",
        "country" : "country",
        "zipCode" : "zip_code",
        "udf1" : "Testing1",
        "udf2" : "Testing2",
        "udf3" : "Testing3",
        "udf4" : "Testing4",
        "udf5" : "Testing5"
    ]
    paymentGatewayViewController.setInputDictionary(inputDictionary: paymentRequestDictionary)
    
}

```

## Step 4
Delegate methods for the payment success and failure  can be handled through this protocol.

```
override func viewDidLoad(){
paymentGatewayViewController.delegate = self
}


extension PaymentProcessViewController:PaymentGatewayDelegate {
    func onPaymentSucess(response: BasisPaymentResponse) {
        self.navigationController?.popViewController(animated: true)
        let alertController = UIAlertController(title: "SUCCESS", message: "order Id \(response.order_id)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func onPaymentFailure(response: BasisPaymentResponse) {
        self.navigationController?.popViewController(animated: true)
        let alertController = UIAlertController(title: "FAILURE", message: " message - \(response.description)", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.view.window?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
```
```

```
## Author

BasisPay, basispay@gmail.com

## License

BasisPay is available under the MIT license. See the LICENSE file for more info.