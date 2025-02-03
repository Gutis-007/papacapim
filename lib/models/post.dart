class Post {
  final String id;
  final String content;
  final String authorId;
  final int likes;
  final List<String> comments;

  Post({
    required this.id,
    required this.content,
    required this.authorId,
    this.likes = 0,
    this.comments = const [],
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      authorId: json['authorId'],
      likes: json['likes'],
      comments: List<String>.from(json['comments']),
    );
  }
}