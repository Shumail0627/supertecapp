class ImagePostModel {
  String? image;
  String? id;

  ImagePostModel({this.image, this.id});

  ImagePostModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['id'] = id;
    return data;
  }
}
