import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/payment_type_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_create_response.dart';
import 'package:active_ecommerce_flutter/data_model/paypal_url_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/data_model/razorpay_payment_success_response.dart';

class PaymentRepository {
  Future<List<PaymentTypeResponse>> getPaymentResponseList({mode = ""}) async {
    final response = await http.get(
      Uri.parse("${AppConfig.BASE_URL}/payment-types?mode=$mode"),
    );

    return paymentTypeResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponse(
      @required int owner_id, @required payment_method) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken().value}'
    };
    var request =
        http.Request('POST', Uri.parse('${AppConfig.BASE_URL}/order/store'));
    request.body = json.encode({
      "owner_id": "$owner_id",
      "user_id": "${UserId().value}",
      "payment_type": "$payment_method"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return orderCreateResponseFromJson(response.body);
  }

  Future<PaypalUrlResponse> getPaypalUrlResponse(@required String payment_type,
      @required int order_id, @required double amount) async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/paypal/payment/url?payment_type=$payment_type&order_id=$order_id&amount=$amount&user_id=${UserId().value}"),
    );

    print(response.body.toString());
    return paypalUrlResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromWallet(
      @required int owner_id,
      @required payment_method,
      @required double amount) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken().value}'
    };
    var request = http.Request(
        'POST', Uri.parse('${AppConfig.BASE_URL}/payments/pay/wallet'));
    request.body = json.encode({
      "owner_id": "$owner_id",
      "user_id": "${UserId().value}",
      "payment_type": "$payment_method",
      "amount": "$amount"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return orderCreateResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromCod(
      @required int owner_id, @required payment_method) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken().value}'
    };
    var request = http.Request(
        'POST', Uri.parse('${AppConfig.BASE_URL}/payments/pay/cod'));
    request.body = json.encode({
      "owner_id": "$owner_id",
      "user_id": "${UserId().value}",
      "payment_type": "$payment_method"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return orderCreateResponseFromJson(response.body);
  }

  Future<RazorpayPaymentSuccessResponse>
      getRazorpayPaymentSuccessResponseResponse(
          @required payment_type,
          @required double amount,
          @required int order_id,
          @required String payment_details) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken().value}'
    };
    var request = http.Request(
        'POST', Uri.parse('${AppConfig.BASE_URL}/razorpay/success'));
    request.body = json.encode({
      "user_id": "${UserId().value}",
      "payment_type": "$payment_type",
      "order_id": "$order_id",
      "amount": "$amount",
      "payment_details": "$payment_details"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return razorpayPaymentSuccessResponseFromJson(response.body);
  }
}
