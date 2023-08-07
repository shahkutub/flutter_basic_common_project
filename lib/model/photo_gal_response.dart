
class PhotoGalleryResponse {
    List<Gallery>? galleries;
    bool? success;

    PhotoGalleryResponse({this.galleries, this.success});

    factory PhotoGalleryResponse.fromJson(Map<String, dynamic> json) {
        return PhotoGalleryResponse(
            galleries: json['galleries'] != null ? (json['galleries'] as List).map((i) => Gallery.fromJson(i)).toList() : null,
            success: json['success'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['success'] = this.success;
        if (this.galleries != null) {
            data['galleries'] = this.galleries!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Gallery {
    String? created_at;
    int? id;
    String? photo;
    String? status;
    String? title;
    String? updated_at;

    Gallery({this.created_at, this.id, this.photo, this.status, this.title, this.updated_at});

    factory Gallery.fromJson(Map<String, dynamic> json) {
        return Gallery(
            created_at: json['created_at'],
            id: json['id'],
            photo: json['photo'],
            status: json['status'],
            title: json['title'],
            updated_at: json['updated_at'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['photo'] = this.photo;
        data['status'] = this.status;
        data['updated_at'] = this.updated_at;
        // if (this.title != null) {
        //     data['title'] = this.title.toJson();
        // }
        return data;
    }
}