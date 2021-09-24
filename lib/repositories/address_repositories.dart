import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/address_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_add_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_delete_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_make_default_response.dart';
import 'package:active_ecommerce_flutter/data_model/address_update_in_cart_response.dart';
import 'package:active_ecommerce_flutter/data_model/city_response.dart';
import 'package:active_ecommerce_flutter/data_model/country_response.dart';
import 'package:active_ecommerce_flutter/data_model/shipping_cost_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class AddressRepository {
  Future<AddressResponse> getAddressList() async {
    final response = await http.get(
      Uri.parse(
          "${AppConfig.BASE_URL}/user/shipping/address/${UserId().value}"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${AccessToken().value}"
      },
    );
    return addressResponseFromJson(response.body);
  }

  Future<AddressAddResponse> getAddressAddResponse(
      @required String address,
      @required String country,
      @required String city,
      @required String postal_code,
      @required String phone) async {
    var post_body = jsonEncode({
      "UserId()": "${UserId().value}",
      "address": "$address",
      "country": "$country",
      "city": "$city",
      "postal_code": "$postal_code",
      "phone": "$phone"
    });
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/user/shipping/create"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${AccessToken().value}"
            },
            body: post_body);

    return addressAddResponseFromJson(response.body);
  }

  Future<AddressUpdateResponse> getAddressUpdateResponse(
      @required int id,
      @required String address,
      @required String country,
      @required String city,
      @required String postal_code,
      @required String phone) async {
    var post_body = jsonEncode({
      "id": "$id",
      "UserId()": "${UserId().value}",
      "address": "$address",
      "country": "$country",
      "city": "$city",
      "postal_code": "$postal_code",
      "phone": "$phone"
    });
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/user/shipping/update"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${AccessToken().value}"
            },
            body: post_body);

    return addressUpdateResponseFromJson(response.body);
  }

  Future<AddressMakeDefaultResponse> getAddressMakeDefaultResponse(
    @required int id,
  ) async {
    var post_body = jsonEncode({
      "UserId()": "${UserId().value}",
      "id": "$id",
    });
    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/user/shipping/make_default"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AccessToken().value}"
        },
        body: post_body);

    return addressMakeDefaultResponseFromJson(response.body);
  }

  Future<AddressDeleteResponse> getAddressDeleteResponse(
    @required int id,
  ) async {
    final response = await http.get(
      Uri.parse("${AppConfig.BASE_URL}/user/shipping/delete/$id"),
      headers: {"Authorization": "Bearer ${AccessToken().value}"},
    );

    return addressDeleteResponseFromJson(response.body);
  }

  Future<CityResponse> getCityList() async {
    final response = await http.get(Uri.parse("${AppConfig.BASE_URL}/cities"));

    return cityResponseFromJson(response.body);
  }

  Future<CountryResponse> getCountryList() async {
    final response =
        await http.get(Uri.parse("${AppConfig.BASE_URL}/countries"));
    return countryResponseFromJson(response.body);
  }

  Future<ShippingCostResponse> getShippingCostResponse(@required int owner_id,
      @required int UserId, @required String city_name) async {
    var post_body = jsonEncode({
      "owner_id": "$owner_id",
      "UserId()": "$UserId",
      "city_name": "$city_name"
    });
    final response =
        await http.post(Uri.parse("${AppConfig.BASE_URL}/shipping_cost"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${AccessToken().value}"
            },
            body: post_body);

    return shippingCostResponseFromJson(response.body);
  }

  Future<AddressUpdateInCartResponse> getAddressUpdateInCartResponse(
    @required int address_id,
  ) async {
    var post_body = jsonEncode(
        {"address_id": "$address_id", "UserId()": "${UserId().value}"});
    final response = await http.post(
        Uri.parse("${AppConfig.BASE_URL}/update-address-in-cart"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${AccessToken().value}"
        },
        body: post_body);

    return addressUpdateInCartResponseFromJson(response.body);
  }
}
