class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  const Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromJson(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }
}
