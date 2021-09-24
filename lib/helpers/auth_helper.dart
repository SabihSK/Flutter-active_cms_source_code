import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class AuthHelper {
  setUserData(loginResponse) {
    if (loginResponse.result == true) {
      IsLoggedIn().value = true;
      AccessToken().value = loginResponse.access_token;
      UserId().value = loginResponse.user.id;
      UserName().value = loginResponse.user.name;
      UserEmail().value = loginResponse.user.email;
      UserPhone().value = loginResponse.user.phone;
      AvatarOriginal().value = loginResponse.user.avatar_original;
    }
  }

  clearUserData() {
    IsLoggedIn().value = false;
    AccessToken().value = "";
    UserId().value = 0;
    UserName().value = "";
    UserEmail().value = "";
    UserPhone().value = "";
    AvatarOriginal().value = "";
  }
}
