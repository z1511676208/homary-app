/// 用户登录
/// 邮箱登录
class UserEmailLoginReq {
  UserEmailLoginReq({
    this.email,
    this.password,
  }) : super();

  String email;
  String password;

  factory UserEmailLoginReq.fromJson(Map<String, dynamic> json) {
    return UserEmailLoginReq(
      email: json["email"],
      password: json["password"],
    );
  }

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

/// 用户登录响应

class UserEmailLoginRes {
  UserEmailLoginRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
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
