import 'package:flutter/material.dart';
import 'package:active_ecommerce_flutter/custom/toast_component.dart';
import 'package:toast/toast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:active_ecommerce_flutter/repositories/payment_repository.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:active_ecommerce_flutter/screens/order_list.dart';
import 'package:active_ecommerce_flutter/screens/wallet.dart';
import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/data_model/razorpay_payment_success_response.dart';

class RazorpayScreen extends StatefulWidget {
  int owner_id;
  double amount;
  String payment_type;
  String payment_method_key;

  RazorpayScreen(
      {Key key,
      this.owner_id = 0,
      this.amount = 0.00,
      this.payment_type = "",
      this.payment_method_key = ""})
      : super(key: key);

  @override
  _RazorpayScreenState createState() => _RazorpayScreenState();
}

class _RazorpayScreenState extends State<RazorpayScreen> {
  int _order_id = 0;
  bool _order_init = false;

  WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.payment_type == "cart_payment") {
      createOrder();
    }
  }

  createOrder() async {
    var orderCreateResponse = await PaymentRepository()
        .getOrderCreateResponse(widget.owner_id, widget.payment_method_key);

    if (orderCreateResponse.result == false) {
      ToastComponent.showDialog(orderCreateResponse.message, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
      Navigator.of(context).pop();
      return;
    }

    _order_id = orderCreateResponse.order_id;
    _order_init = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: buildBody(),
    );
  }

  void getData() {
    print('called.........');
    var payment_details = '';
    _webViewController
        .evaluateJavascript("document.body.innerText")
        .then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      //print(responseJSON.toString());
      if (responseJSON["result"] == false) {
        Toast.show(responseJSON["message"], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);

        Navigator.pop(context);
      } else if (responseJSON["result"] == true) {
        payment_details = responseJSON['payment_details'];
        onPaymentSuccess(payment_details);
      }
    });
  }

  onPaymentSuccess(payment_details) async {
    var razorpayPaymentSuccessResponse = await PaymentRepository()
        .getRazorpayPaymentSuccessResponseResponse(
            widget.payment_type, widget.amount, _order_id, payment_details);

    if (razorpayPaymentSuccessResponse.result == false) {
      Toast.show(razorpayPaymentSuccessResponse.message, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
      Navigator.pop(context);
      return;
    }

    Toast.show(razorpayPaymentSuccessResponse.message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
    if (widget.payment_type == "cart_payment") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return OrderList(from_checkout: true);
      }));
    } else if (widget.payment_type == "wallet_payment") {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Wallet(from_recharge: true);
      }));
    }
  }

  buildBody() {
    String initial_url =
        "${AppConfig.BASE_URL}/razorpay/pay-with-razorpay?payment_type=${widget.payment_type}&order_id=${_order_id}&amount=${widget.amount}&user_id=${UserId().value}";

    //print("init url");
    //print(initial_url);

    if (_order_init == false &&
        _order_id == 0 &&
        widget.payment_type == "cart_payment") {
      return Container(
        child: Center(
          child: Text("Creating order ..."),
        ),
      );
    } else {
      return SizedBox.expand(
        child: Container(
          child: WebView(
            debuggingEnabled: false,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) {
              _webViewController = controller;
              _webViewController.loadUrl(initial_url);
            },
            onWebResourceError: (error) {},
            onPageFinished: (page) {
              //print(page.toString());
              getData();
            },
          ),
        ),
      );
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      title: Text(
        "Pay with Razorpay",
        style: TextStyle(fontSize: 16, color: MyTheme.accent_color),
      ),
      elevation: 0.0,
      titleSpacing: 0,
    );
  }
}
