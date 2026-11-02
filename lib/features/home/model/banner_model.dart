import 'package:cloud_firestore/cloud_firestore.dart';

class BannerModel {
  int? statusCode;
  List<BannerData>? data;
  String? message;

  BannerModel({this.statusCode, this.data, this.message});

  BannerModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    if (json['data'] != null) {
      data = <BannerData>[];
      json['data'].forEach((v) {
        data!.add(BannerData.fromJson(v));
      });
    }
    message = json['message'];
  }
}

class BannerData {
  String? documentId;
  int? id;
  String? title;
  String? description;
  String? image;
  String? link;
  bool? isActive;
  String? position;
  int? priority;
  String? startDate;
  String? endDate;
  String? createdAt;

  BannerData({
    this.id,
    this.title,
    this.description,
    this.image,
    this.link,
    this.isActive,
    this.position,
    this.priority,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  BannerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    link = json['link'];
    isActive = json['isActive'];
    position = json['position'];
    priority = json['priority'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
  }

  factory BannerData.fromFirestore(
    String documentId,
    Map<String, dynamic> data,
  ) {
    final json = Map<String, dynamic>.from(data);
    for (final key in ['startDate', 'endDate', 'createdAt']) {
      final value = json[key];
      if (value is Timestamp) {
        json[key] = value.toDate().toUtc().toIso8601String();
      }
    }
    return BannerData.fromJson(json)..documentId = documentId;
  }
}
