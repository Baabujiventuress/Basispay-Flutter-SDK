package com.basispaysdk

import android.app.Activity
import android.content.Intent
import android.util.Log
import android.widget.Toast
import androidx.annotation.NonNull
import com.example.paymentgateway.PGConstants
import com.example.paymentgateway.PaymentGatewayPaymentInitializer
import com.example.paymentgateway.PaymentParams

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONObject
import java.lang.Error

/** BasispaysdkPlugin */
class BasispaysdkPlugin: FlutterPlugin, ActivityAware,MethodCallHandler, PluginRegistry.ActivityResultListener {

  private lateinit var channel : MethodChannel
  private lateinit var result: Result
  private var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "basispaysdk")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "startTransaction") {
      startTransaction(call)
      this.result = result
    } else {
      result.notImplemented()
    }
  }

  private fun startTransaction(call: MethodCall){
    val arg = call.arguments as Map<*, *>?
    if (arg != null) {
      val apiKey = arg["apiKey"] as String?
      val returnUrl = arg["returnUrl"] as String?
      val endPoint = arg["endPoint"] as Boolean?
      var mode: String? = null
      if (apiKey == null) return showToast("apikey is missing")
      if (returnUrl == null) return showToast("returnUrl is missing")
      if (endPoint == null) return showToast("endPoint is missing")

      if (endPoint == true) {
        mode = "TEST"
      }else {
        mode = "LIVE"
      }
      val payDict = arg["payDict"] as Map<*, *>?
      if (payDict == null) return showToast("payDict is missing")
      val orderId = payDict!!["orderId"] as String?
      val amount = payDict!!["amount"] as String?
      val currency = payDict["currency"] as String?
      val description = payDict["description"] as String?
      val name = payDict["name"] as String?
      val email = payDict["email"] as String?
      val phone = payDict["phone"] as String?
      val addressLine1 = payDict["addressLine1"] as String?
      val addressLine2 = payDict["addressLine2"] as String?
      val city = payDict["city"] as String?
      val state = payDict["state"] as String?
      val country = payDict["country"] as String?
      val zipCode = payDict["zipCode"] as String?
      val udf1 = payDict["udf1"] as String?
      val udf2 = payDict["udf2"] as String?
      val udf3 = payDict["udf3"] as String?
      val udf4 = payDict["udf4"] as String?
      val udf5 = payDict["udf5"] as String?
      if (orderId == null) return showToast("orderId is missing")
      if (amount == null) return showToast("amount is missing")
      if (currency == null) return showToast("currency is missing")
      if (description == null) return showToast("description is missing")
      if (name == null) return showToast("name is missing")
      if (email == null) return showToast("email is missing")
      if (phone == null) return showToast("phone is missing")
      if (addressLine1 == null) return showToast("addressLine1 is missing")
      if (addressLine2 == null) return showToast("addressLine2 is missing")
      if (city == null) return showToast("city is missing")
      if (state == null) return showToast("state is missing")
      if (country == null) return showToast("country is missing")
      if (zipCode == null) return showToast("zipCode is missing")
      if (udf1 == null) return showToast("udf1 is missing")
      if (udf2 == null) return showToast("udf2 is missing")
      if (udf3 == null) return showToast("udf3 is missing")
      if (udf4 == null) return showToast("udf4 is missing")
      if (udf5 == null) return showToast("udf5 is missing")
      val pgPaymentParams = PaymentParams()
      pgPaymentParams.setAPiKey(apiKey);
      pgPaymentParams.setAmount(amount);
      pgPaymentParams.setEmail(email);
      pgPaymentParams.setName(name);
      pgPaymentParams.setPhone(phone);
      pgPaymentParams.setOrderId(orderId);
      pgPaymentParams.setCurrency(currency);
      pgPaymentParams.setDescription(description);
      pgPaymentParams.setCity(city);
      pgPaymentParams.setState(state);
      pgPaymentParams.setAddressLine1(addressLine1);
      pgPaymentParams.setAddressLine2(addressLine2);
      pgPaymentParams.setZipCode(zipCode);
      pgPaymentParams.setCountry(country);
      pgPaymentParams.setReturnUrl(returnUrl);
      pgPaymentParams.setMode(mode);
      pgPaymentParams.setUdf1(udf1);
      pgPaymentParams.setUdf2(udf2);
      pgPaymentParams.setUdf3(udf3);
      pgPaymentParams.setUdf4(udf4);
      pgPaymentParams.setUdf5(udf5);
      val pgPaymentInitialzer = PaymentGatewayPaymentInitializer(pgPaymentParams, activity)
      pgPaymentInitialzer.initiatePaymentProcess()
    }

  }

  private fun showToast(message: String) {
    Toast.makeText(activity!!, message, Toast.LENGTH_LONG).show()
  }

  override fun onDetachedFromActivity() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }


  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun setResult(message: String?, value: HashMap<String, String?>? = null) {
    result.error("0", message ?: "Unknown error", value)
  }

  private fun setResult(value: HashMap<String, String?>) {
    result.success(value)
  }


  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {

    if (requestCode == PGConstants.REQUEST_CODE) {
      if (resultCode == Activity.RESULT_OK) {
        try {
          val paymentResponse = data?.getStringExtra(PGConstants.PAYMENT_RESPONSE)
          if (paymentResponse.equals("null")) {
            System.out.println("Transaction Error!")
          } else {
            val response = JSONObject(paymentResponse)
            val result = HashMap<String, String?>()
            for (key: String in response.keys()) {
              result[key] = response.getString(key)
            }
            setResult(result)
          }

        } catch (e: Error) {
          setResult(e.message)
        }

      }
      if (resultCode == Activity.RESULT_CANCELED) {
        setResult("payment Cancelled")
      }
    }
    return true
  }
}
