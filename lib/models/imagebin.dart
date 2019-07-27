class ImageBin {
  int id;
  int categoryId;
  final String url;
  final List<String> tags;

  ImageBin({this.categoryId, this.url, this.tags, this.id});

  factory ImageBin.fromJson(Map<String, dynamic> json) => new ImageBin(
      id: json["id"],
      categoryId: json["categoryId"],
      url: json["url"],
      tags: json["tags"].toString().split(","));

  Map<String, dynamic> toJson() =>
      {"id": id, "categoryId": categoryId, "url": url, "tags": tags};
}
