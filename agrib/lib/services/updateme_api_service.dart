import 'dart:convert';
import 'dart:io';
import 'package:agrib/updateme/updateme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkHelper {

  Future getData(count_updateme) async {

    final Map<String, String> bodyData = {
      "secret_key": "@@^%&^kdsfkjdkfUM",
      "last_id":count_updateme,
    };

    final response = await http.post(Uri.parse('http://192.168.1.102/backend_api/ws.php'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
        },
        body: bodyData
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      } else {
        print(response.statusCode.toString());
        return null;
      }

  }
}
