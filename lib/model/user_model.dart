class UserModel {
  String? userId;
  String? name;
  String? email;
  String? phone;
  String? profilePic;
  String? token;
  String? userType;
  String? createdAt;
  String? updatedAt;
  bool? isMedic;
  MedicDetails? medicDetails;

UserModel({
    this.userId,
    this.name,
    this.email,
    this.phone,
    this.profilePic,
    this.token,
    this.userType,
    this.createdAt,
    this.updatedAt,
    this.isMedic,
    this.medicDetails,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profilePic = json['profilePic'];
    token = json['token'];
    userType = json['userType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isMedic = json['isMedic'];
    medicDetails = json['medicDetails'] != null
        ? MedicDetails.fromJson(json['medicDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['profilePic'] = profilePic;
    data['token'] = token;
    data['userType'] = userType;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['isMedic'] = isMedic;
    if (medicDetails != null) {
      data['medicDetails'] = medicDetails!.toJson();
    }
    return data;
  }
}

class MedicDetails {
  String? storeName;
  String? storePhone;
  String? storeOwnerName;
  String? storeAddress;
  String? storeCity;
  String? storeState;
  String? drugLicense;

  MedicDetails({
    this.storeName,
    this.storePhone,
    this.storeOwnerName,
    this.storeAddress,
    this.storeCity,
    this.storeState,
    this.drugLicense,
  });

  MedicDetails.fromJson(Map<String, dynamic> json) {
    storeName = json['storeName'];
    storePhone = json['storePhone'];
    storeOwnerName = json['storeOwnerName'];
    storeAddress = json['storeAddress'];
    storeCity = json['storeCity'];
    storeState = json['storeState'];
    drugLicense = json['drugLicense'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['storeName'] = storeName;
    data['storePhone'] = storePhone;
    data['storeOwnerName'] = storeOwnerName;
    data['storeAddress'] = storeAddress;
    data['storeCity'] = storeCity;
    data['storeState'] = storeState;
    data['drugLicense'] = drugLicense;
    return data;
  }
}
