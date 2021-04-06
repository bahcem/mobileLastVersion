import 'package:flutter/material.dart';

class Setting {
  String appName = '';
  double defaultTax;
  String defaultCurrency;
  String distanceUnit;
  bool currencyRight = false;
  int currencyDecimalDigits = 2;
  String mainColor;
  String mainDarkColor;
  String secondColor;
  String secondDarkColor;
  String accentColor;
  String accentDarkColor;
  String scaffoldDarkColor;
  String scaffoldColor;
  String googleMapsKey;
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('tr', ''));
  ValueNotifier<Brightness> brightness = new ValueNotifier(Brightness.light);

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null;
      mainColor = jsonMap['main_color'] ?? null;
      mainDarkColor = jsonMap['main_dark_color'] ?? '';
      secondColor = jsonMap['second_color'] ?? '';
      secondDarkColor = jsonMap['second_dark_color'] ?? '';
      accentColor = jsonMap['accent_color'] ?? '';
      accentDarkColor = jsonMap['accent_dark_color'] ?? '';
      scaffoldDarkColor = jsonMap['scaffold_dark_color'] ?? '';
      scaffoldColor = jsonMap['scaffold_color'] ?? '';
      googleMapsKey = jsonMap['google_maps_key'] ?? null;
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "en", '');
      distanceUnit = jsonMap['distance_unit'] ?? 'km';
      defaultTax = double.tryParse(jsonMap['default_tax']) ??
          0.0; //double.parse(jsonMap['default_tax'].toString());
      defaultCurrency = jsonMap['default_currency'] ?? '';
      currencyDecimalDigits =
          int.tryParse(jsonMap['default_currency_decimal_digits']) ?? 2;
      currencyRight =
          jsonMap['currency_right'] == null || jsonMap['currency_right'] == '0'
              ? false
              : true;
    } catch (e) {}
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["default_tax"] = defaultTax;
    map["default_currency"] = defaultCurrency;
    map["default_currency_decimal_digits"] = currencyDecimalDigits;
    map["currency_right"] = currencyRight;
    map["mobile_language"] = mobileLanguage.value.languageCode;
    return map;
  }
}
