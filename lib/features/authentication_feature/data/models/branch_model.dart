import 'package:cubic_task/features/authentication_feature/domain/entities/branch_entity.dart';

List<BranchModel> branchesListFromJson(List str) => List<BranchModel>.from(
      str.map(
        (x) => BranchModel.fromJson(x),
      ),
    );

class BranchModel extends BranchEntity {
  BranchModel({
    required super.id,
    super.branchCode,
    super.branchName,
    super.branchNameAr,
    super.branchCity,
    super.branchLat,
    super.branchLng,
    super.branchAddress,
    super.branchCountryCode,
    super.branchStatus,
  });

  /// From Json
  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      id: json['id'],
      branchCode: json['branchcode'],
      branchName: json['branchname'],
      branchNameAr: json['branchnamear'],
      branchCity: json['branchcity'],
      branchLat: json['branchlat'] != null
          ? double.tryParse(json['branchlat'].toString())
          : null,
      branchLng: json['branchlng'] != null
          ? double.tryParse(json['branchlng'].toString())
          : null,
      branchAddress: json['branchaddress'],
      branchCountryCode: json['branchcountrycode'],
      branchStatus: json['branchstatus'],
    );
  }

  /// To Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branchcode': branchCode,
      'branchname': branchName,
      'branchnamear': branchNameAr,
      'branchcity': branchCity,
      'branchlat': branchLat,
      'branchlng': branchLng,
      'branchaddress': branchAddress,
      'branchcountrycode': branchCountryCode,
      'branchstatus': branchStatus,
    };
  }
}
