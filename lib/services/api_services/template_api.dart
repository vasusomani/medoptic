import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:medoptic/model/medtag_model.dart';
import 'package:medoptic/model/template_model.dart';

import '../firebase_services/phone_auth_service.dart';

class TemplateApi {
  final String baseUrl = dotenv.env['BASE_URL']!;

  // Create Template Api
  Future createTemplate({
    required Template template,
  }) async {
    try {
      final body = jsonEncode(template.toJson());
      final url = Uri.parse('$baseUrl/template/createTemplate');
      final String? token = await PhoneAuthService.getIdToken();
      var response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );
      if (response.statusCode == 201) {
        debugPrint("Create Template Post ${response.body}");
        log("Create Template Success");
        return jsonDecode(response.body);
      } else {
        log("Create Template Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw 'Failed to create template, please try again later';
      }
    } catch (e) {
      log("Create Template Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Get Template by ID Api
  Future getTemplate({
    required String templateId,
  }) async {
    try {
      final url =
          Uri.parse('$baseUrl/template/getTemplate?templateId=$templateId');
      final token = await PhoneAuthService.getIdToken();
      var response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        debugPrint("Get Template ${response.body}");
        log("Get Template Success");
        return jsonDecode(response.body);
      } else {
        log("Get Template Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw 'Failed to get template, please try again later';
      }
    } catch (e) {
      log("Get Template Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Get All Templates Api
  Future getAllTemplates() async {
    try {
      final url = Uri.parse('$baseUrl/template/getAllTemplates');
      final token = await PhoneAuthService.getIdToken();
      var response = await http.get(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        debugPrint("Get All Templates ${response.body}");
        log("Get All Templates Success");
        return jsonDecode(response.body);
      } else {
        log("Get All Templates Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw 'Failed to get all templates, please try again later';
      }
    } catch (e) {
      log("Get All Templates Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Update Template Api
  Future updateTemplate({
    required Template template,
  }) async {
    try {
      final body = jsonEncode(template.toJson());
      final url =
          Uri.parse('$baseUrl/template/updateTemplate/${template.templateId}');
      final String? token = await PhoneAuthService.getIdToken();
      var response = await http.post(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: body,
      );
      if (response.statusCode == 200) {
        debugPrint("Update Template Post ${response.body}");
        log("Update Template Success");
        return jsonDecode(response.body);
      } else {
        log("Update Template Failed");
        debugPrint(response.statusCode.toString());
        debugPrint(response.body);
        throw 'Failed to update template, please try again later';
      }
    } catch (e) {
      log("Update Template Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }

  // Delete Template Api
  Future deleteTemplate({
    required String templateId,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/template/deleteTemplate/$templateId');
      final String? token = await PhoneAuthService.getIdToken();
      var response = await http.delete(
        url,
        headers: {
          "Content-type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        debugPrint("Delete Template Success: ${response.body}");
        log("Delete Template Success");
        return response.statusCode == 200
            ? jsonDecode(response.body)
            : {'message': 'Template deleted successfully'};
      } else {
        log("Delete Template Failed");
        debugPrint('Status Code: ${response.statusCode}');
        debugPrint('Response Body: ${response.body}');
        throw 'Failed to delete template, please try again later';
      }
    } catch (e) {
      log("Delete Template Failed");
      debugPrint(e.toString());
      rethrow;
    }
  }
}
