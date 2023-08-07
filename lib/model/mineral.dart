import 'category.dart';

class Minerals {

  List<Masters>? masters;
  List<SubCategory>? subCategory;
  String? parentCategoryName;
  Minerals({this.masters,this.subCategory,this.parentCategoryName});

  Minerals.fromJson(Map<String, dynamic> json) {
    parentCategoryName = json['name'];
    if (json['masters'] != null) {
      masters = <Masters>[];
      json['masters'].forEach((v) {
        masters!.add(Masters.fromJson(v));
      });
    }

    if (json['sub_categories'] != null) {
      subCategory = <SubCategory>[];
      json['sub_categories'].forEach((v) {
        subCategory!.add(SubCategory.fromJson(v));
      });
    }
  }
}

class Masters {
  int? id;
  String? title;
  String? categoryName;
  String? image;
  String? description;
  int? status;
  List<String>? galleries;
  bool? isSubCat;

  Masters(
      {this.id,
      this.title,
      this.categoryName,
      this.image,
      this.status,
      this.description,
      this.galleries,
      this.isSubCat
      });

  Masters.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    description = json['description'];
    status = json['status'];
    if (json['galleries'] != null) {
      galleries = <String>[];
      json['galleries'].forEach((v) {
        galleries!.add(v['image']);
      });
    }
  }
}