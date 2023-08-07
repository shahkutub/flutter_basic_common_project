
class AppointmentResponse {
    String? success;
    List<Visitor>? visitors;

    AppointmentResponse({this.success, this.visitors});

    factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
        return AppointmentResponse(
            success: json['success'],
            visitors: json['visitors'] != null ? (json['visitors'] as List).map((i) => Visitor.fromJson(i)).toList() : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['success'] = this.success;
        if (this.visitors != null) {
            data['visitors'] = this.visitors!.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Visitor {
    String? created_at;
    int? id;
    String? name;
    String? phone;
    int? status;
    String? updated_at;
    int? user_id;
    String? visite_date;

    Visitor({this.created_at, this.id, this.name, this.phone, this.status, this.updated_at, this.user_id, this.visite_date});

    factory Visitor.fromJson(Map<String, dynamic> json) {
        return Visitor(
            created_at: json['created_at'],
            id: json['id'],
            name: json['name'],
            phone: json['phone'],
            status: json['status'],
            updated_at: json['updated_at'],
            user_id: json['user_id'],
            visite_date: json['visite_date'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['created_at'] = this.created_at;
        data['id'] = this.id;
        data['name'] = this.name;
        data['phone'] = this.phone;
        data['status'] = this.status;
        data['updated_at'] = this.updated_at;
        data['user_id'] = this.user_id;
        data['visite_date'] = this.visite_date;
        return data;
    }
}