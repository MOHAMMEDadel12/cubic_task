import 'package:cubic_task/features/authentication_feature/domain/entities/user_entity.dart';


List<UserModel> usersListFromJson(List str) => List<UserModel>.from(
  str.map(
        (x) => UserModel.fromJson(x),
  ),
);


class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.imageUrl,
    super.name,
    super.email,
    super.phone,
    super.type,
  });

  /// From Json ----
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      imageUrl: json['image'],
      type: json['type'],
    );
  }

  /// To Json
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name":name,
      "email": email,
      "phone": name,
      "image": imageUrl,
      "type": type,
    };
  }
}
