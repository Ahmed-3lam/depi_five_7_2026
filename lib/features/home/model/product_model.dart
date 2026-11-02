import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  int? statusCode;
  ProductData? data;
  String? message;

  ProductModel({this.statusCode, this.data, this.message});

  ProductModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    data = json['data'] != null ? ProductData.fromJson(json['data']) : null;
    message = json['message'];
  }
}

class ProductData {
  List<Products>? products;
  Pagination? pagination;

  ProductData({this.products, this.pagination});

  ProductData.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }
}

class Products {
  String? documentId;
  int? id;
  String? name;
  String? description;
  double? price;
  int? categoryId;
  String? image;
  int? stock;
  double? rating;
  int? reviews;
  String? brand;
  String? createdAt;

  Products({
    this.id,
    this.name,
    this.description,
    this.price,
    this.categoryId,
    this.image,
    this.stock,
    this.rating,
    this.reviews,
    this.brand,
    this.createdAt,
  });

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = (json['price'] as num?)?.toDouble();
    categoryId = json['categoryId'];
    image = json['image'];
    stock = json['stock'];
    rating = (json['rating'] as num?)?.toDouble();
    reviews = json['reviews'];
    brand = json['brand'];
    createdAt = json['createdAt'];
  }

  factory Products.fromFirestore(String documentId, Map<String, dynamic> data) {
    final json = Map<String, dynamic>.from(data);
    final createdAt = json['createdAt'];
    if (createdAt is Timestamp) {
      json['createdAt'] = createdAt.toDate().toUtc().toIso8601String();
    }
    return Products.fromJson(json)..documentId = documentId;
  }
}

class Pagination {
  int? page;
  int? limit;
  int? total;
  int? pages;

  Pagination({this.page, this.limit, this.total, this.pages});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    limit = json['limit'];
    total = json['total'];
    pages = json['pages'];
  }
}
