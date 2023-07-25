import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:core';

Future sendPostRequest(BuildContext context, endpoint, dynamic data) async {
  try {
    final response = await Dio().post(endpoint, data: data);

    print(
      "_______print response ${response.data}",
    );
    if (response.data['status'] != 201) {
      // ErrorDialog.showErrorDialog(context, response.data['message'].toString());
    }
    return response.data;
  } catch (e) {
    return null;
  }
}

Future getRequest(String endpoint) async {
  try {
    final response = await Dio().get(endpoint);

    return response;
  } catch (e) {
    print(e);
  }
}

Future getRequestById(String endpoint, int object_id) async {
  try {
    final response = await Dio().get(endpoint);
    print(
      "_______print response ${response.data}",
    );

    return response.data;
  } catch (e) {
    print(e);
  }
}
