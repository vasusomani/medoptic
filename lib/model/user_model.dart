import 'package:medoptic/model/template_model.dart';

class UserModel {
  // String? userId;
  String? name;
  String? storeName;
  String? storeAddress;
  // String? email;
  String? phone;
  String? profilePic;
  // String? token;
  List<Template>? templates;
  String? createdAt;
  String? updatedAt;

  UserModel({
    // this.userId,
    this.name,
    this.storeName,
    this.storeAddress,
    // this.email,
    this.phone,
    this.profilePic,
    // this.token,
    this.templates,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    // userId = json['userId'];
    name = json['name'];
    storeName = json['storeName'];
    storeAddress = json['storeAddress'];
    // email = json['email'];
    phone = json['phone'];
    profilePic = json['profilePic'];
    // token = json['token'];
    templates = json['templates'] != null
        ? (json['templates'] as List).map((i) => Template.fromJson(i)).toList()
        : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['userId'] = userId;
    data['name'] = name;
    data['storeName'] = storeName;
    data['storeAddress'] = storeAddress;
    // data['email'] = email;
    data['phone'] = phone;
    data['profilePic'] = profilePic;
    // data['token'] = token;
    templates != null
        ? data['templates'] = templates!.map((i) => i.toJson()).toList()
        : null;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
