class CategoryResponse {
  int id;
  String name;
  String tags;
  String image;

  CategoryResponse({int id, String name, String tags, String image});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.tags = json['tags'];
    this.image = json['image'];
  }
}
