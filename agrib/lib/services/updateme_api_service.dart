import 'dart:convert';
import 'dart:io';
import 'package:agrib/updateme/updateme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class NetworkHelper {

  String ipurl="http://192.168.1.101";

  Future getData(count_updateme) async {

    final Map<String, String> bodyData = {
      "secret_key": "1@@^%&^kdsfkjdkfUM",
      "last_id":count_updateme,
    };

    final response = await http.post(Uri.parse(ipurl+'/backend_api/ws.php'),
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
  Future getDataKnowledgeUp(count_knowledgeup) async {

    final Map<String, String> bodyData = {
      "secret_key": "2@@^%&^kdsfkjdkfUM",
      "last_id":count_knowledgeup,
    };

    final response = await http.post(Uri.parse(ipurl+'/backend_api/knowledgeup_ws.php'),
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

  Future getDataBestFit(count_bestfit) async {

    final Map<String, String> bodyData = {
      "secret_key": "3@@^%&^kdsfkjdkfUM",
      "last_id":count_bestfit,
    };

    final response = await http.post(Uri.parse(ipurl+'/backend_api/bestfit_ws.php'),
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

  Future getTemperature(lat,lan) async {
    print("abcdefg");
    final Map<String, String> bodyData = {
      "secret_key": "4@@^%&^kdsfkjdkfUM",
      "lat":lat.toString(),
      "lan": lan.toString(),
    };

    final response = await http.post(Uri.parse(ipurl+'/backend_api/temparature_ws.php'),
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
