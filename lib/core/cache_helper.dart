import 'dart:convert';

import 'package:edugate/features/home/models/university_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static List<UniversityModel> getFavorite() {
    List<String> data = sharedPreferences.getStringList('favorite') ?? [];
    return data.map((e) => UniversityModel.fromJson(jsonDecode(e))).toList();
  }

  static Future<bool> changeFavourite(UniversityModel item) async {
    bool saved = false;
    List<UniversityModel> universities = getFavorite();
    if (universities.any((university) => university.id == item.id)) {
      universities.removeWhere((university) => university.id == item.id);
      saved = false;
    } else {
      universities.add(item);
      saved = true;
    }

    sharedPreferences.setStringList(
      'favorite',
      universities.map((e) => jsonEncode(e.toJson())).toList(),
    );

    return saved;
  }

  static bool isFavorite(String id) {
    List<UniversityModel> universities = getFavorite();
    return universities.any((university) => university.id == id);
  }
}
