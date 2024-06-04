class BranchEntity {
  final String id;
  final String? branchCode;
  final String? branchName;
  final String? branchNameAr;
  final String? branchCity;
  final double? branchLat;
  final double? branchLng;
  final String? branchAddress;
  final String? branchCountryCode;
  final int? branchStatus;

  BranchEntity({
    required this.id,
    this.branchCode,
    required this.branchName,
    this.branchNameAr,
    this.branchCity,
    this.branchLat,
    this.branchLng,
    this.branchAddress,
    this.branchCountryCode,
    required this.branchStatus,
  });
}
