class PostModel {
  late int userId;
  late int id;
  String? title;
  String? body;

  PostModel({
    required this.userId,
    required this.id,
    this.title,
    this.body,
  });

  PostModel.fromMap(Map<String, dynamic> json) {
    userId = json["userId"];
    id = json["id"];
    title = json["title"];
    body = json["body"];
  }
}
