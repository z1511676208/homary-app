import 'dart:convert';

class HomeReviewModuleRes {
  HomeReviewModuleRes({
    this.code,
    this.data,
    this.message,
  });

  int code;
  ReviewData data;
  String message;

  factory HomeReviewModuleRes.fromRawJson(String str) =>
      HomeReviewModuleRes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeReviewModuleRes.fromJson(Map<String, dynamic> json) =>
      HomeReviewModuleRes(
        code: json["code"],
        data: ReviewData.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "data": data.toJson(),
        "message": message,
      };
}

class ReviewData {
  ReviewData(
      {this.title,
      this.moreJumpUrl,
      this.avgScore,
      this.reviewList,
      this.eventLabel});

  String title;
  String moreJumpUrl;
  String eventLabel;
  List<ReviewList> reviewList;
  dynamic avgScore;

  factory ReviewData.fromRawJson(String str) =>
      ReviewData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewData.fromJson(Map<String, dynamic> json) => ReviewData(
        title: json["title"],
        avgScore: json["avg_score"],
        eventLabel: json["event_label"],
        moreJumpUrl: json["more_jump_url"],
        reviewList: List<ReviewList>.from(
            json["review_list"].map((x) => ReviewList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "avg_score": avgScore,
        "more_jump_url": moreJumpUrl,
        "event_label": eventLabel,
        "review_list": List<dynamic>.from(reviewList.map((x) => x.toJson())),
      };
}

class ReviewList {
  ReviewList(
      {this.productImage,
      this.imgUrl,
      this.jumpUrl,
      this.username,
      this.score,
      this.title,
      this.content,
      this.job,
      this.headImg,
      this.eventLabel});

  String productImage;
  String imgUrl;
  String jumpUrl;
  String username;
  dynamic score;
  String title;
  String content;
  String eventLabel;
  String job;
  String headImg;

  factory ReviewList.fromRawJson(String str) =>
      ReviewList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewList.fromJson(Map<String, dynamic> json) => ReviewList(
        productImage: json["product_image"],
        imgUrl: json["img_url"],
        jumpUrl: json["jump_url"],
        username: json["username"],
        score: json["score"],
        title: json["title"],
        content: json["content"],
        job: json["job"],
        headImg: json["head_img"],
        eventLabel: json["event_label"] == null ? null : json["event_label"],
      );

  Map<String, dynamic> toJson() => {
        "product_image": productImage,
        "img_url": imgUrl,
        "jump_url": jumpUrl,
        "username": username,
        "score": score,
        "title": title,
        "content": content,
        "job": job,
        "head_img": headImg,
        "event_label": eventLabel == null ? null : eventLabel,
      };
}
