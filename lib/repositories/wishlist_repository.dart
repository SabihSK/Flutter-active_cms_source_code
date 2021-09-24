import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/wishlist_check_response.dart';
import 'package:active_ecommerce_flutter/data_model/wishlist_delete_response.dart';
import 'package:active_ecommerce_flutter/data_model/wishlist_response.dart';
import 'package:flutter/foundation.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class WishListRepository {
  Future<WishlistResponse> getUserWishlist() async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request(
        'GET', Uri.parse('${AppConfig.BASE_URL}/wishlists/${UserId().value}'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return wishlistResponseFromJson(response.body);
  }

  Future<WishlistDeleteResponse> delete({
    @required int wishlist_id = 0,
  }) async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request(
        'DELETE', Uri.parse('${AppConfig.BASE_URL}/wishlists/$wishlist_id'));
    request.bodyFields = {};
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return wishlistDeleteResponseFromJson(response.body);
  }

  Future<WishListChekResponse> isProductInUserWishList(
      {@required product_id = 0}) async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.BASE_URL}/wishlists-check-product?product_id=$product_id&user_id=${UserId().value}'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return wishListChekResponseFromJson(response.body);
  }

  Future<WishListChekResponse> add({@required product_id = 0}) async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.BASE_URL}/wishlists-add-product?product_id=$product_id&user_id=${UserId().value}'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return wishListChekResponseFromJson(response.body);
  }

  Future<WishListChekResponse> remove({@required product_id = 0}) async {
    var headers = {'Authorization': 'Bearer ${AccessToken().value}'};
    var request = http.Request(
        'GET',
        Uri.parse(
            '${AppConfig.BASE_URL}/wishlists-remove-product?product_id=$product_id&user_id=${UserId().value}'));

    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    return wishListChekResponseFromJson(response.body);
  }
}
