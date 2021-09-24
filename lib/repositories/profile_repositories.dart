import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/profile_image_update_response.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/profile_counters_response.dart';
import 'package:active_ecommerce_flutter/data_model/profile_update_response.dart';

import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class ProfileRepository {
  Future<ProfileCountersResponse> getProfileCountersResponse() async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request('GET',
        Uri.parse('{AppConfig.BASE_URL}/profile/counters/${UserId().value}'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return profileCountersResponseFromJson(response.body);
  }

  Future<ProfileUpdateResponse> getProfileUpdateResponse(
      @required String name, @required String password) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken().value}'
    };
    var request =
        http.Request('POST', Uri.parse('${AppConfig.BASE_URL}/profile/update'));
    request.body = json.encode(
        {"id": "${UserId().value}", "name": "$name", "password": "$password"});
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return profileUpdateResponseFromJson(response.body);
  }

  Future<ProfileImageUpdateResponse> getProfileImageUpdateResponse(
      @required String image, @required String filename) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${AccessToken().value}'
    };
    var request = http.Request(
        'POST', Uri.parse('${AppConfig.BASE_URL}/profile/update-image'));
    request.body = json.encode({
      "id": "${UserId().value}",
      "image": "$image",
      "filename": "$filename"
    });
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return profileImageUpdateResponseFromJson(response.body);
  }
}
