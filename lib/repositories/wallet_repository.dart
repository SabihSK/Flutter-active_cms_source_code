import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/wallet_balance_response.dart';
import 'package:active_ecommerce_flutter/data_model/wallet_recharge_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class WalletRepository {
  Future<WalletBalanceResponse> getBalance() async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request('GET',
        Uri.parse('${AppConfig.BASE_URL}/wallet/balance/${UserId().value}'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return walletBalanceResponseFromJson(response.body);
  }

  Future<WalletRechargeResponse> getRechargeList({int page = 1}) async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.BASE_URL}/wallet/history/${UserId().value}?page=$page'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return walletRechargeResponseFromJson(response.body);
  }
}
