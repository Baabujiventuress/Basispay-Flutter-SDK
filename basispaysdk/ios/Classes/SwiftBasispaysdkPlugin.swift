import Flutter
import UIKit
import BasisPay

public class SwiftBasispaysdkPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "basispaysdk", binaryMessenger: registrar.messenger())
    let instance = SwiftBasispaysdkPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

   public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
          if call.method.elementsEqual("startTransaction") {
              guard let parameters = call.arguments as? [String:Any] else {

                  return
              }
              guard let apiKey = parameters["apiKey"] as? String else {

                  return
              }
              guard let saltKey = parameters["saltKey"] as? String else {

                  return
              }
              guard let returnUrl = parameters["returnUrl"] as? String else {

                  return
              }
              guard let endPoint = parameters["endPoint"] as? Bool else {

                  return
              }
              guard let payDict = parameters["payDict"] as? NSDictionary else {

                  return
              }

              startTransaction(apiKey: apiKey, saltKey: saltKey, returnUrl: returnUrl, endPoint: .Testing, paymentRequestDictionary: payDict, callBack: result)

          }else {
              result("Technical Error")
          }
      }

      public func startTransaction(apiKey:String,saltKey:String,returnUrl:String,endPoint:UrlEndpoint,paymentRequestDictionary:NSDictionary, callBack: @escaping FlutterResult){
          DispatchQueue.main.async {
          let paymentDefaults = PaymentDefaults(apiKey: apiKey, saltKey: saltKey, returnUrl: returnUrl, endPoint: endPoint)
              if let window = UIApplication.shared.delegate?.window {
                  let basisStoryBoardBundle = Bundle(for: BasisPayViewController.self)
                  let basisStoryBoard = UIStoryboard(name: "Basis", bundle: basisStoryBoardBundle)
                  let basisVc = basisStoryBoard.instantiateViewController(withIdentifier: "BasisPayViewController") as! BasisPayViewController
                  basisVc.paymentRequestDictionary = paymentRequestDictionary
                  basisVc.paymentDefault = paymentDefaults
                  basisVc.flutterCallBackResult = callBack
                  let flutterVC = window?.rootViewController as! FlutterViewController
                  basisVc.modalPresentationStyle = .fullScreen
                  flutterVC.present(basisVc, animated: true, completion: nil)
              }
          }

      }
}

  class BasisPayViewController: UIViewController {

      @IBOutlet weak var containerView: UIView!
      var paymentGatewayViewController: PaymentGatewayController!
      var amount:String?
      var titleValue:String?
      var descriptionValue:String?
      var paymentDefault:PaymentDefaults!
      var paymentRequestDictionary:NSDictionary!
      var response:BasisPaymentResponse?
      var paymentResponse:BasisPaymentResponse?
      var flutterCallBackResult:FlutterResult?
      override func viewDidLoad() {
          super.viewDidLoad()
      }

      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
          setDefaults()
          setInputDictionary()
      }

      private func setDefaults() {
          paymentGatewayViewController = PaymentGatewayController()
          paymentGatewayViewController.paymentDefaults = paymentDefault
          paymentGatewayViewController.delegate = self
          self.containerView.addSubview(paymentGatewayViewController.view)
      }

      private func setInputDictionary(){
          paymentGatewayViewController.setInputDictionary(inputDictionary: paymentRequestDictionary)
      }

  }
  extension BasisPayViewController:PaymentGatewayDelegate {
      func onPaymentSucess(response: BasisPaymentResponse) {
          if let result = flutterCallBackResult {
              result(response.toDict())
              self.dismiss(animated: true, completion: nil)
          }
      }

      func onPaymentFailure(response: BasisPaymentResponse) {
          if let result = flutterCallBackResult {
              result(response.toDict())
              self.dismiss(animated: true, completion: nil)
          }
      }

  }


  extension BasisPaymentResponse {

      func toDict()->[String:Any]{
          return
              ["address_line_1":self.address_line_1,"address_line_2":self.address_line_2,"amount":self.amount,"cardmasked":self.cardmasked,"city":self.city,"country":self.country,"currency":self.currency,"description":self.description,"email":self.email,"error_desc":self.error_desc,"name":self.name,"order_id":self.order_id,"payment_channel":self.payment_channel,"payment_datetime":self.payment_datetime,"payment_mode":self.payment_mode,"phone":self.phone,"response_code":self.response_code,"response_message":self.response_message,"state":self.state,"transaction_id":self.transaction_id,"zip_code":self.zip_code,"strCategory":self.strCategory]
      }
  }
