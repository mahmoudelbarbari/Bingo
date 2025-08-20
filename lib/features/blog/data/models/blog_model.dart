class BlogModel {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final bool isDeleted;
  final BlogAuthor author;
  final List<BlogLike> likes;
  final List<BlogComment> comments;
  final int likesCount;
  final int commentsCount;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.isDeleted,
    required this.author,
    required this.likes,
    required this.comments,
    required this.likesCount,
    required this.commentsCount,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      imageUrl: json['imageUrl'] ?? json['coverImage'],
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? '',
      isDeleted: json['isDeleted'] ?? false,
      author: BlogAuthor.fromJson(json['author'] ?? {}),
      likes: (json['likes'] as List<dynamic>?)
          ?.map((like) => BlogLike.fromJson(like))
          .toList() ?? [],
      comments: (json['comments'] as List<dynamic>?)
          ?.map((comment) => BlogComment.fromJson(comment))
          .toList() ?? [],
      likesCount: json['likesCount'] ?? 0,
      commentsCount: json['commentsCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'isDeleted': isDeleted,
      'author': author.toJson(),
      'likes': likes.map((like) => like.toJson()).toList(),
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'likesCount': likesCount,
      'commentsCount': commentsCount,
    };
  }
}

class BlogAuthor {
  final String id;
  final String name;
  final String email;
  final BlogShop? shop;

  BlogAuthor({
    required this.id,
    required this.name,
    required this.email,
    this.shop,
  });

  factory BlogAuthor.fromJson(Map<String, dynamic> json) {
    return BlogAuthor(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      shop: json['shop'] != null ? BlogShop.fromJson(json['shop']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'shop': shop?.toJson(),
    };
  }
}

class BlogShop {
  final BlogAvatar? avatar;

  BlogShop({this.avatar});

  factory BlogShop.fromJson(Map<String, dynamic> json) {
    return BlogShop(
      avatar: json['avatar'] != null ? BlogAvatar.fromJson(json['avatar']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatar': avatar?.toJson(),
    };
  }
}

class BlogAvatar {
  final String url;

  BlogAvatar({required this.url});

  factory BlogAvatar.fromJson(Map<String, dynamic> json) {
    return BlogAvatar(
      url: json['url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }
}

class BlogLike {
  final String id;
  final BlogUser user;

  BlogLike({
    required this.id,
    required this.user,
  });

  factory BlogLike.fromJson(Map<String, dynamic> json) {
    return BlogLike(
      id: json['id'] ?? '',
      user: BlogUser.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
    };
  }
}

class BlogComment {
  final String id;
  final String content;
  final DateTime createdAt;
  final BlogUser user;
  final bool isDeleted;
  final DateTime? deletedAt;

  BlogComment({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.user,
    required this.isDeleted,
    this.deletedAt,
  });

  factory BlogComment.fromJson(Map<String, dynamic> json) {
    return BlogComment(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      user: BlogUser.fromJson(json['user'] ?? {}),
      isDeleted: json['isDeleted'] ?? false,
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'user': user.toJson(),
      'isDeleted': isDeleted,
      'deletedAt': deletedAt?.toIso8601String(),
    };
  }
}

class BlogUser {
  final String id;
  final String name;
  final BlogAvatar? avatar;

  BlogUser({
    required this.id,
    required this.name,
    this.avatar,
  });

  factory BlogUser.fromJson(Map<String, dynamic> json) {
    return BlogUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] != null ? BlogAvatar.fromJson(json['avatar']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatar': avatar?.toJson(),
    };
  }
}

class CommentReportModel {
  final String commentId;
  final String reason;
  final String? description;

  CommentReportModel({
    required this.commentId,
    required this.reason,
    this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'reason': reason,
      'description': description,
    };
  }
}
