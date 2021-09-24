import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/review_response.dart';
import 'package:active_ecommerce_flutter/data_model/review_submit_response.dart';

import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class ReviewRepository {
  Future<ReviewResponse> getReviewResponse(@required int product_id,
      {page = 1}) async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.BASE_URL}/reviews/product/$product_id?page=$page'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return reviewResponseFromJson(response.body);
  }

  Future<ReviewSubmitResponse> getReviewSubmitResponse(
    @required int product_id,
    @required int rating,
    @required String comment,
  ) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken().value}'
    };
    var request =
        http.Request('POST', Uri.parse('${AppConfig.BASE_URL}/reviews/submit'));
    request.body = json.encode({
      "product_id": "$product_id",
      "user_id": "${UserId().value}",
      "rating": "$rating",
      "comment": "$comment"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return reviewSubmitResponseFromJson(response.body);
  }
}
