class SuccessModel {
  bool? status;
  String? msg;

  SuccessModel({this.status, this.msg});

  SuccessModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = msg;
    return data;
  }
}
