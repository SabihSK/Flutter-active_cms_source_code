import 'package:shared_value/shared_value.dart';

final SharedValue<bool> is_logged_in = SharedValue(
  value: false, // initial value
  key: "is_logged_in", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<String> access_token = SharedValue(
  value: "", // initial value
  key: "access_token", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<int> user_id = SharedValue(
  value: 0, // initial value
  key: "user_id", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<String> avatar_original = SharedValue(
  value: "", // initial value
  key: "avatar_original", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<String> user_name = SharedValue(
  value: "", // initial value
  key: "user_name", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<String> user_email = SharedValue(
  value: "", // initial value
  key: "user_email", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

final SharedValue<String> user_phone = SharedValue(
  value: "", // initial value
  key: "user_phone", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);

//!--------------------------------xxxxxxxxxx-----------
class IsLoggedIn {
  bool value = false;
}

class AccessToken {
  String value =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImNjZGIxZGM3MGQ5NDkyMTY0NDY0YTAxNzE2YmU0NjM4MjYwOWQzNGIwOWNhMTUyYmM3ZDBiMjUwZDMyNGNkZDIzMTA5YTEyOThiYWIyNGZmIn0.eyJhdWQiOiIxIiwianRpIjoiY2NkYjFkYzcwZDk0OTIxNjQ0NjRhMDE3MTZiZTQ2MzgyNjA5ZDM0YjA5Y2ExNTJiYzdkMGIyNTBkMzI0Y2RkMjMxMDlhMTI5OGJhYjI0ZmYiLCJpYXQiOjE2MzIyNTQxNjYsIm5iZiI6MTYzMjI1NDE2NiwiZXhwIjoxNjYzNzkwMTY2LCJzdWIiOiIyMSIsInNjb3BlcyI6W119.k97NnszdCa0nZPBHqIY_H7IJ4rMxfYMUM2Q8EjVEoVcfxMD4JeEQrxxtEUFZn8JhiGUPPiez4UyyhtNVQ2vZvbamLhmD9kQMPUXjjMLvwIWM_WBDxO7IkmJxBwQ678D26ocZbmysNETuVhHhET__GsuqZjYRuB7TSVhtL9XTqffdvuvj9c8qSAJTh1kCToO57kL2eD7D9okQYNlcCy9XFVysK1LpTrITJXI4Q8h5fXM2gJ7_KCrMasANNE9miGi6tqKuUz3O7Bq8DXEps3gCK-1AE0VhjpWW3mSB4kxXCaFqEb4P-i_siVR1Nx0bAJDVjBV0OVTRW2PEaavkonqR3eL1Uhd-P7Il2k3y8UFK2zhtk_csH49oejvP9WTN6kvGlyGPC16nsc-C0-vZtSBzZgBe4cflWe1U2osArKuEiN3fFdbBGAKCWIpyCRjtYhD7vlQMzwYoozf6GDc11SGlWzXm2FjyduskrxusAAs4fQEo-boKmNLldpy_WV2g8su863k-6BWm-FEN5woqz8rhACgbmlyXJdO8XlA6-tt_DrrkX1lexEU40DTAwl3_oFTxaT09YWAJKOy_MmMzCkLUG-7q9R54Z3cnj4Zi5vT1IYNZlAUZCkW0pYJ8df0PXpe6GJ4NeFKK2CE0tOHq5Ha2F4VeyXbnlv_yiX4JTMjDCK4";
}

class UserId {
  int value = 0;
}

class AvatarOriginal {
  String value = "";
}

class UserName {
  String value = "";
}

class UserEmail {
  String value = "";
}

class UserPhone {
  String value = "";
}
