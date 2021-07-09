
// 首页商品响应
class HomeProductsRes {
  HomeProductsRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  Data data;
  String message;

  factory HomeProductsRes.fromJson(Map<String, dynamic> json) =>
      HomeProductsRes(
        code: json["code"] == null ? null : json["code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
      };
}

class Data {
  Data({
    this.modules,
    this.seoData,
  });

  List<Module> modules;
  SeoData seoData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        modules: json["modules"] == null
            ? null
            : List<Module>.from(json["modules"].map((x) => Module.fromJson(x))),
        seoData: json["seo_data"] == null
            ? null
            : SeoData.fromJson(json["seo_data"]),
      );

  Map<String, dynamic> toJson() => {
        "modules": modules == null
            ? null
            : List<dynamic>.from(modules.map((x) => x.toJson())),
        "seo_data": seoData == null ? null : seoData.toJson(),
      };
}

class Module {
  Module({
    this.moduleType,
    this.moduleData,
  });

  int moduleType;
  ModuleData moduleData;

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        moduleType: json["module_type"] == null ? null : json["module_type"],
        moduleData: json["module_data"] == null
            ? null
            : ModuleData.fromJson(json["module_data"]),
      );

  Map<String, dynamic> toJson() => {
        "module_type": moduleType == null ? null : moduleType,
        "module_data": moduleData == null ? null : moduleData.toJson(),
      };
}

class ModuleData {
  ModuleData({
    this.list,
    this.serviceList,
  });

  List<ListElement> list;
  List<ServiceList> serviceList;

  factory ModuleData.fromJson(Map<String, dynamic> json) => ModuleData(
        list: json["list"] == null
            ? null
            : List<ListElement>.from(
                json["list"].map((x) => ListElement.fromJson(x))),
        serviceList: json["service_list"] == null
            ? null
            : List<ServiceList>.from(
                json["service_list"].map((x) => ServiceList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "list": list == null
            ? null
            : List<dynamic>.from(list.map((x) => x.toJson())),
        "service_list": serviceList == null
            ? null
            : List<dynamic>.from(serviceList.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.advertId,
    this.title,
    this.imgUrl,
    this.jumpUrl,
    this.bgColor,
  });

  String advertId;
  String title;
  String imgUrl;
  String jumpUrl;
  BgColor bgColor;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        advertId: json["advert_id"] == null ? null : json["advert_id"],
        title: json["title"] == null ? null : json["title"],
        imgUrl: json["img_url"] == null ? null : json["img_url"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
        bgColor: json["bg_color"] == null
            ? null
            : bgColorValues.map[json["bg_color"]],
      );

  Map<String, dynamic> toJson() => {
        "advert_id": advertId == null ? null : advertId,
        "title": title == null ? null : title,
        "img_url": imgUrl == null ? null : imgUrl,
        "jump_url": jumpUrl == null ? null : jumpUrl,
        "bg_color": bgColor == null ? null : bgColorValues.reverse[bgColor],
      };
}

enum BgColor { EMPTY, A14141 }

final bgColorValues =
    EnumValues({"#A14141": BgColor.A14141, "": BgColor.EMPTY});

class ServiceList {
  ServiceList({
    this.name,
    this.icon,
    this.jumpUrl,
  });

  String name;
  String icon;
  String jumpUrl;

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
        name: json["name"] == null ? null : json["name"],
        icon: json["icon"] == null ? null : json["icon"],
        jumpUrl: json["jump_url"] == null ? null : json["jump_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "icon": icon == null ? null : icon,
        "jump_url": jumpUrl == null ? null : jumpUrl,
      };
}

class SeoData {
  SeoData({
    this.seoTitle,
    this.seoKeyword,
    this.seoDescription,
  });

  String seoTitle;
  String seoKeyword;
  String seoDescription;

  factory SeoData.fromJson(Map<String, dynamic> json) => SeoData(
        seoTitle: json["seo_title"] == null ? null : json["seo_title"],
        seoKeyword: json["seo_keyword"] == null ? null : json["seo_keyword"],
        seoDescription:
            json["seo_description"] == null ? null : json["seo_description"],
      );

  Map<String, dynamic> toJson() => {
        "seo_title": seoTitle == null ? null : seoTitle,
        "seo_keyword": seoKeyword == null ? null : seoKeyword,
        "seo_description": seoDescription == null ? null : seoDescription,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
