class CompanyCategory {
  final String companyCategoryId;
  final String categoryName;

  CompanyCategory({this.categoryName, this.companyCategoryId});

  factory CompanyCategory.fromJson(json) {
    return CompanyCategory(
      companyCategoryId: json["companyCategoryId"],
      categoryName: json["categoryName"],
    );
  }

  Map<String, dynamic> toJson() {
    var data = Map<String, dynamic>();
    data["categoryName"] = this.categoryName;
    data["companyCategoryId"] = this.companyCategoryId;
    return data;
  }
}
