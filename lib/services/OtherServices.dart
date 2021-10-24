import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:myapp/evnironment/Api.dart';
import 'package:myapp/models/Age.dart';
import 'package:myapp/models/Plan.dart';

class OtherService {
  // static String apiUrl = "";
  // final String apiUrl = "https://localhost:5001/Subscription/";
  ApiURL api = new ApiURL();
  Future<List<AgeGroup>> getAgeList() async {
    String url = api.geturl + "Subscription/Age";
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      return compute(parseAge, res.body);
    } else {
      throw "Failed to load Age list";
    }
  }

  Future<List<Plan>> getPlanList() async {
    String url = api.geturl + "Subscription/Plans";
    final res = await get(Uri.parse(url));
    if (res.statusCode == 200) {
      return compute(parsedata, res.body);
    } else {
      throw "Failed to load Plan list";
    }
  }

  List<Plan> parsedata(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<Plan>((json) => Plan.fromJson(json)).toList();
  }

  List<AgeGroup> parseAge(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<AgeGroup>((json) => AgeGroup.fromJson(json)).toList();
  }
}
