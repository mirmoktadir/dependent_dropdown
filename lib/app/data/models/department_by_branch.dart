class DepartmentByBranch {
  DepartmentByBranch({
    this.message,
    this.success,
    this.status,
    this.data,
  });

  DepartmentByBranch.fromJson(dynamic json) {
    message = json['message'];
    success = json['success'];
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DptData.fromJson(v));
      });
    }
  }
  dynamic message;
  bool? success;
  int? status;
  List<DptData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['success'] = success;
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class DptData {
  DptData({
    this.id,
    this.branchId,
    this.name,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
  });

  DptData.fromJson(dynamic json) {
    id = json['id'];
    branchId = json['branch_id'];
    name = json['name'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  int? branchId;
  String? name;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['branch_id'] = branchId;
    map['name'] = name;
    map['created_by'] = createdBy;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }
}
