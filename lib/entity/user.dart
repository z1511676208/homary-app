/// 用户登录
/// 邮箱登录
class UserEmailLoginReq {
  UserEmailLoginReq({this.email, this.password, this.deviceNumber}) : super();

  String email;
  String password;
  String deviceNumber;

  factory UserEmailLoginReq.fromJson(Map<String, dynamic> json) {
    return UserEmailLoginReq(
      email: json["email"],
      password: json["password"],
      deviceNumber: json["device_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "device_number": deviceNumber,
      };
}

//第三方登录
class UserThirdLoginReq {
  UserThirdLoginReq({this.idToken, this.oauthVerifier, this.deviceNumber})
      : super();
  String idToken;
  String oauthVerifier;
  String deviceNumber;

  factory UserThirdLoginReq.fromJson(Map<String, dynamic> json) {
    return UserThirdLoginReq(
      idToken: json["id_token"],
      oauthVerifier: json["oauth_verifier"],
      deviceNumber: json["device_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_token": idToken,
        "oauth_verifier": oauthVerifier,
        "device_number": deviceNumber,
      };
}

class UserSendEmailReq {
  UserSendEmailReq({this.email, this.type}) : super();
  String email;
  int type;
  factory UserSendEmailReq.fromJson(Map<String, dynamic> json) {
    return UserSendEmailReq(
      email: json["email"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toJson() => {"email": email, "type": type};
}

//用户注册
class UserRegisterReq {
  UserRegisterReq(
      {this.email, this.password, this.subscribe, this.deviceNumber})
      : super();
  int subscribe;
  String email;
  String password;
  String deviceNumber;
  factory UserRegisterReq.fromJson(Map<String, dynamic> json) {
    return UserRegisterReq(
      email: json["email"],
      password: json["password"],
      subscribe: json["subscribe"],
      deviceNumber: json["device_number"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "subscribe": subscribe,
        "device_number": deviceNumber,
      };
}

/// 用户登录响应

class UserEmailLoginRes {
  UserEmailLoginRes({
    this.code,
    this.data,
    this.message,
  });

  dynamic code;
  Data data;
  String message;

  factory UserEmailLoginRes.fromJson(Map<String, dynamic> json) =>
      UserEmailLoginRes(
        code: json["code"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  Data({
    this.email,
    this.account,
    this.firstName,
    this.lastName,
    this.nickName,
    this.id,
    this.userId,
    this.sex,
    this.type,
    this.delFlag,
    this.isOldUser,
    this.drawNewUserCoupon,
    this.sexName,
    this.typeName,
    this.subscribe,
    this.authInfo,
    this.isCreateOrder,
    this.token,
  });

  String email;
  String account;
  String firstName;
  String lastName;
  String nickName;
  String id;
  String userId;
  String sex;
  String type;
  String delFlag;
  String isOldUser;
  String drawNewUserCoupon;
  String sexName;
  String typeName;
  int subscribe;
  dynamic authInfo;
  String isCreateOrder;
  String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        account: json["account"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        nickName: json["nick_name"],
        id: json["id"],
        userId: json["user_id"],
        sex: json["sex"],
        type: json["type"],
        delFlag: json["del_flag"],
        isOldUser: json["is_old_user"],
        drawNewUserCoupon: json["draw_new_user_coupon"],
        sexName: json["sex_name"],
        typeName: json["type_name"],
        subscribe: json["subscribe"],
        authInfo: json["subscribe"],
        isCreateOrder: json["is_create_order"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "account": account,
        "first_name": firstName,
        "last_name": lastName,
        "nick_name": nickName,
        "id": id,
        "user_id": userId,
        "sex": sex,
        "type": type,
        "del_flag": delFlag,
        "is_old_user": isOldUser,
        "draw_new_user_coupon": drawNewUserCoupon,
        "sex_name": sexName,
        "type_name": typeName,
        "subscribe": subscribe,
        "auth_info": subscribe,
        "is_create_order": isCreateOrder,
        "token": token,
      };
}

class AuthInfo {
  AuthInfo({
    this.name,
    this.email,
    this.identifier,
    this.type,
  });

  String name;
  String email;
  String identifier;
  String type;

  factory AuthInfo.fromJson(Map<String, dynamic> json) => AuthInfo(
        name: json["name"],
        email: json["email"],
        identifier: json["identifier"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "identifier": identifier,
        "type": type,
      };
}
