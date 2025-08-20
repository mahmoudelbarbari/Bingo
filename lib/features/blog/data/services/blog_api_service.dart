import 'package:dio/dio.dart';
import '../../../../core/network/dio_provider.dart';
import '../models/blog_model.dart';

class BlogApiService {
  late Dio _dio;

  BlogApiService() {
    _initializeDio();
  }

  Future<void> _initializeDio() async {
    _dio = await DioClient.createDio(ApiTarget.blog);
  }

  /// Get all published blogs
  Future<List<BlogModel>> getAllPublishedBlogs() async {
    try {
      await _initializeDio();
      final response = await _dio.get('');
      
      if (response.data['success'] == true) {
        final List<dynamic> blogsData = response.data['data'];
        return blogsData.map((blog) => BlogModel.fromJson(blog)).toList();
      } else {
        throw Exception('Failed to fetch blogs');
      }
    } catch (e) {
      throw Exception('Error fetching blogs: $e');
    }
  }

  /// Add a comment to a blog
  Future<BlogComment> addComment(String blogId, String content) async {
    try {
      await _initializeDio();
      final response = await _dio.post(
        '/$blogId/comments',
        data: {'content': content},
      );
      
      if (response.data['success'] == true) {
        return BlogComment.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to add comment');
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to add comment';
        throw Exception(errorMessage);
      }
      throw Exception('Error adding comment: $e');
    }
  }

  /// Toggle like on a blog
  Future<Map<String, dynamic>> toggleLike(String blogId) async {
    try {
      await _initializeDio();
      final response = await _dio.post('/$blogId/likes');
      
      if (response.data['success'] == true) {
        return {
          'liked': response.data['liked'],
          'message': response.data['message'],
        };
      } else {
        throw Exception(response.data['message'] ?? 'Failed to toggle like');
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to toggle like';
        throw Exception(errorMessage);
      }
      throw Exception('Error toggling like: $e');
    }
  }

  /// Update a comment
  Future<BlogComment> updateComment(String commentId, String content) async {
    try {
      await _initializeDio();
      final response = await _dio.put(
        '/comments/$commentId',
        data: {'content': content},
      );
      
      if (response.data['success'] == true) {
        return BlogComment.fromJson(response.data['data']);
      } else {
        throw Exception(response.data['message'] ?? 'Failed to update comment');
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to update comment';
        throw Exception(errorMessage);
      }
      throw Exception('Error updating comment: $e');
    }
  }

  /// Delete a comment
  Future<void> deleteComment(String commentId) async {
    try {
      await _initializeDio();
      final response = await _dio.delete('/comments/$commentId');
      
      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to delete comment');
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to delete comment';
        throw Exception(errorMessage);
      }
      throw Exception('Error deleting comment: $e');
    }
  }

  /// Report a comment
  Future<void> reportComment(String commentId, String reason, {String? description}) async {
    try {
      await _initializeDio();
      final response = await _dio.post(
        '/comments/$commentId/report',
        data: {
          'reason': reason,
          if (description != null) 'description': description,
        },
      );
      
      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to report comment');
      }
    } catch (e) {
      if (e is DioException) {
        final errorMessage = e.response?.data['message'] ?? 'Failed to report comment';
        throw Exception(errorMessage);
      }
      throw Exception('Error reporting comment: $e');
    }
  }
}
