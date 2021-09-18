// To parse this JSON data, do
//
//     final searchAssociate = searchAssociateFromJson(jsonString);

import 'dart:convert';

class SearchAssociate {
  SearchAssociate({
    this.code,
    this.data,
    this.message,
  });

  int code;
  SearchAssociateData data;
  String message;

  factory SearchAssociate.fromRawJson(String str) => SearchAssociate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchAssociate.fromJson(Map<String, dynamic> json) => SearchAssociate(
    code: json["code"] == null ? null : json["code"],
    data: json["data"] == null ? null : SearchAssociateData.fromJson(json["data"]),
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "code": code == null ? null : code,
    "data": data == null ? null : data.toJson(),
    "message": message == null ? null : message,
  };
}

class SearchAssociateData {
  SearchAssociateData({
    this.wordList,
  });

  List<WordList> wordList;

  factory SearchAssociateData.fromRawJson(String str) => SearchAssociateData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchAssociateData.fromJson(Map<String, dynamic> json) => SearchAssociateData(
    wordList: json["word_list"] == null ? null : List<WordList>.from(json["word_list"].map((x) => WordList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "word_list": wordList == null ? null : List<dynamic>.from(wordList.map((x) => x.toJson())),
  };
}

class WordList {
  WordList({
    this.word,
  });

  String word;

  factory WordList.fromRawJson(String str) => WordList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WordList.fromJson(Map<String, dynamic> json) => WordList(
    word: json["word"] == null ? null : json["word"],
  );

  Map<String, dynamic> toJson() => {
    "word": word == null ? null : word,
  };
}
