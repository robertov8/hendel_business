class CompanyResponse {
  int id;
  String fantasyName;
  String logo;
  List categories;
  String description;
  int size;

  CompanyResponse({this.id, this.fantasyName, this.logo, this.categories});

  CompanyResponse.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.fantasyName = json["fantasy_name"];
    this.logo = json["logo"];
    this.categories = json["categories"];
    this.description = json["description"];
    this.size = json["size"];
  }

  String toString() {
    return 'id: $id, fantasyName: $fantasyName, logo: $logo, categories: $categories, size: $size';
  }
}
