class UserModel {
  String? userId;
  String? name;
  String? storeName;
  String? storeAddress;
  String? email;
  String? phone;
  String? profilePic;
  String? token;
  String? createdAt;
  String? updatedAt;

  UserModel({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.token,
    this.createdAt,
    this.updatedAt,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    storeName = json['storeName'];
    storeAddress = json['storeAddress'];
    email = json['email'];
    phone = json['phone'];
    profilePic = json['profilePic'];
    token = json['token'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['storeName'] = storeName;
    data['storeAddress'] = storeAddress;
    data['email'] = email;
    data['phone'] = phone;
    data['profilePic'] = profilePic;
    data['token'] = token;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

// class MedicDetails {
//   String? storeName;
//   String? storePhone;
//   String? storeOwnerName;
//   String? storeAddress;
//   String? storeCity;
//   String? storeState;
//   String? drugLicense;
//
//   MedicDetails({
//     this.storeName,
//     this.storePhone,
//     this.storeOwnerName,
//     this.storeAddress,
//     this.storeCity,
//     this.storeState,
//     this.drugLicense,
//   });
//
//   MedicDetails.fromJson(Map<String, dynamic> json) {
//     storeName = json['storeName'];
//     storePhone = json['storePhone'];
//     storeOwnerName = json['storeOwnerName'];
//     storeAddress = json['storeAddress'];
//     storeCity = json['storeCity'];
//     storeState = json['storeState'];
//     drugLicense = json['drugLicense'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['storeName'] = storeName;
//     data['storePhone'] = storePhone;
//     data['storeOwnerName'] = storeOwnerName;
//     data['storeAddress'] = storeAddress;
//     data['storeCity'] = storeCity;
//     data['storeState'] = storeState;
//     data['drugLicense'] = drugLicense;
//     return data;
//   }
// }
