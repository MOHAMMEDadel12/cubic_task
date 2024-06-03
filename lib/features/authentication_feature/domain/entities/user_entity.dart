import 'package:cubic_task/core/utils/constants/enums/invite_users_error_enums.dart';
import 'package:cubic_task/core/utils/constants/enums/workspace_member_role_enums.dart';

class UserEntity {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? imageUrl;
  final String? type;


  UserEntity({
    this.id,
    this.email,
    this.name,
    this.imageUrl,
    this.phone,
    this.type,
  });
}
