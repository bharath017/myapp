import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:myapp/services/SignUpService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../evnironment/Api.dart';
import 'package:http/http.dart' as http;

class PaymentService {
  SharedPreferences? preferences;
  SignUpService _service = new SignUpService();
  ApiURL api = new ApiURL();

  void linkCustomerWithPaymentMethod(String pm_id, BuildContext context) async {
    this.preferences = await SharedPreferences.getInstance();
    var UserId = this.preferences?.getInt("UserId");
    final response = await http.get(
      Uri.parse(api.geturl +
          'Payments/LinkCustomerAndPM/' +
          UserId.toString() +
          '/' +
          pm_id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      var formdata = this.preferences!.getString("SubData");

      _service.Subscribe1(formdata.toString(), context);
      // PaymentMethod mod = PaymentMethod.fromJson(jsonDecode(response.body));
      // var PlanId = this.preferences!.getInt("PlanId");
      // final res = await http.get(
      //   Uri.parse(api.geturl +
      //       'Payments/AddStripeSubscription/' +
      //       UserId.toString() +
      //       '/' +
      //       pm_id),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8',
      //   },
      // );
    } else {
      print(response.body);
      final snackBar = SnackBar(
        content: const Text('Failed to make payment'),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
