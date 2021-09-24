import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:active_ecommerce_flutter/data_model/product_mini_response.dart';
import 'package:active_ecommerce_flutter/data_model/product_details_response.dart';
import 'package:active_ecommerce_flutter/data_model/variant_response.dart';
import 'package:flutter/foundation.dart';

class ProductRepository {
  Future<ProductMiniResponse> getFeaturedProducts() async {
    try {
      final response =
          await http.get(Uri.parse("${AppConfig.BASE_URL}/products/featured"));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getBestSellingProducts() async {
    try {
      final response = await http
          .get(Uri.parse("${AppConfig.BASE_URL}/products/best-seller"));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getTodaysDealProducts() async {
    try {
      final response = await http
          .get(Uri.parse("${AppConfig.BASE_URL}/products/todays-deal"));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getFlashDealProducts(
      {@required int id = 0}) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppConfig.BASE_URL}/flash-deal-products/" + id.toString()));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getCategoryProducts(
      {@required int id = 0, name = "", page = 1}) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppConfig.BASE_URL}/products/category/" +
              id.toString() +
              "?page=${page}&name=${name}"));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getShopProducts(
      {@required int id = 0, name = "", page = 1}) async {
    try {
      var url = "${AppConfig.BASE_URL}/products/seller/" +
          id.toString() +
          "?page=${page}&name=${name}";

      final response = await http.get(Uri.parse(url));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getBrandProducts(
      {@required int id = 0, name = "", page = 1}) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppConfig.BASE_URL}/products/brand/" +
              id.toString() +
              "?page=${page}&name=${name}"));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getFilteredProducts(
      {name = "",
      sort_key = "",
      page = 1,
      brands = "",
      categories = "",
      min = "",
      max = ""}) async {
    try {
      var url = "${AppConfig.BASE_URL}/products/search" +
          "?page=${page}&name=${name}&sort_key=${sort_key}&brands=${brands}&categories=${categories}&min=${min}&max=${max}";

      //print("url:" + url);
      final response = await http.get(Uri.parse(url));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductDetailsResponse> getProductDetails(
      {@required int id = 0}) async {
    try {
      final response = await http
          .get(Uri.parse("${AppConfig.BASE_URL}/products/" + id.toString()));
      return productDetailsResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getRelatedProducts({@required int id = 0}) async {
    try {
      final response = await http.get(
          Uri.parse("${AppConfig.BASE_URL}/products/related/" + id.toString()));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<ProductMiniResponse> getTopFromThisSellerProducts(
      {@required int id = 0}) async {
    try {
      final response = await http.get(Uri.parse(
          "${AppConfig.BASE_URL}/products/top-from-seller/" + id.toString()));
      return productMiniResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }

  Future<VariantResponse> getVariantWiseInfo(
      {int id = 0, color = '', variants = ''}) async {
    try {
      var url =
          "${AppConfig.BASE_URL}/products/variant/price?id=${id.toString()}&color=${color}&variants=${variants}";

      final response = await http.get(Uri.parse(url));

      return variantResponseFromJson(response.body);
    } catch (e) {
      print(e);
    }
  }
}
