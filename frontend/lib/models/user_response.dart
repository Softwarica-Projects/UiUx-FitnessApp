class UserResponse {
  Data? data;

  UserResponse({this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? displayName;
  String? email;
  String? username;
  String? gender;
  String? status;
  String? userType;
  String? phoneNumber;
  String? playerId;
  String? profileImage;
  String? loginType;
  String? createdAt;
  String? updatedAt;
  UserProfile? userProfile;

  Data(
      {this.id,
      this.firstName,
      this.lastName,
      this.displayName,
      this.email,
      this.username,
      this.gender,
      this.status,
      this.userType,
      this.phoneNumber,
      this.playerId,
      this.profileImage,
      this.loginType,
      this.createdAt,
      this.updatedAt,
      this.userProfile});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    displayName = json['display_name'];
    email = json['email'];
    username = json['username'];
    gender = json['gender'];
    status = json['status'];
    userType = json['user_type'];
    phoneNumber = json['phone_number'];
    playerId = json['player_id'];
    profileImage = json['profile_image'];
    loginType = json['login_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userProfile = json['user_profile'] != null ? new UserProfile.fromJson(json['user_profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['user_type'] = this.userType;
    data['phone_number'] = this.phoneNumber;
    data['player_id'] = this.playerId;
    data['profile_image'] = this.profileImage;
    data['login_type'] = this.loginType;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userProfile != null) {
      data['user_profile'] = this.userProfile!.toJson();
    }
    return data;
  }
}

class UserProfile {
  int? id;
  String? age;
  String? weight;
  String? weightUnit;
  String? height;
  String? heightUnit;
  String? address;
  int? userId;
  String? createdAt;
  String? updatedAt;

  UserProfile({this.id, this.age, this.weight, this.weightUnit, this.height, this.heightUnit, this.address, this.userId, this.createdAt, this.updatedAt});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    age = json['age'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    height = json['height'];
    heightUnit = json['height_unit'];
    address = json['address'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['weight_unit'] = this.weightUnit;
    data['height'] = this.height;
    data['height_unit'] = this.heightUnit;
    data['address'] = this.address;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
