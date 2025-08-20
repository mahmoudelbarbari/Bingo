import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_post_card.dart';
import '../../data/models/blog_model.dart';
import '../../data/services/blog_api_service.dart';
import 'comments_page.dart';

class BlogListPage extends StatefulWidget {
  const BlogListPage({Key? key}) : super(key: key);

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  final BlogApiService _blogApiService = BlogApiService();
  List<BlogModel> _blogs = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadBlogs();
  }

  Future<void> _loadBlogs() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final blogs = await _blogApiService.getAllPublishedBlogs();
      setState(() {
        _blogs = blogs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshBlogs() async {
    await _loadBlogs();
  }

  void _navigateToComments(BlogModel blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          final idx = _blogs.indexWhere((b) => b.id == blog.id);
          return CommentsPage(
            blog: blog,
            blogIndex: idx,
            onIncrementComment: () {
              if (idx >= 0) {
                final current = _blogs[idx];
                setState(() {
                  _blogs[idx] = BlogModel(
                    id: current.id,
                    title: current.title,
                    content: current.content,
                    imageUrl: current.imageUrl,
                    createdAt: current.createdAt,
                    updatedAt: current.updatedAt,
                    status: current.status,
                    isDeleted: current.isDeleted,
                    author: current.author,
                    likes: current.likes,
                    comments: current.comments,
                    likesCount: current.likesCount,
                    commentsCount: current.commentsCount + 1,
                  );
                });
              }
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _refreshBlogs,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 64,
                        color: Colors.red,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Error loading blogs',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _refreshBlogs,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _blogs.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.article_outlined,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No blog posts available',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Check back later for new posts!',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: _refreshBlogs,
                      child: ListView.builder(
                        itemCount: _blogs.length,
                        itemBuilder: (context, index) {
                          final blog = _blogs[index];
                          return PostCardWidget(
                            blog: blog,
                            onCommentTap: () => _navigateToComments(blog),
                            onLikeChanged: (isLiked) {
                              // Update the blog's like count in the list
                              setState(() {
                                if (isLiked) {
                                  _blogs[index] = BlogModel(
                                    id: blog.id,
                                    title: blog.title,
                                    content: blog.content,
                                    imageUrl: blog.imageUrl,
                                    createdAt: blog.createdAt,
                                    updatedAt: blog.updatedAt,
                                    status: blog.status,
                                    isDeleted: blog.isDeleted,
                                    author: blog.author,
                                    likes: blog.likes,
                                    comments: blog.comments,
                                    likesCount: blog.likesCount + 1,
                                    commentsCount: blog.commentsCount,
                                  );
                                } else {
                                  _blogs[index] = BlogModel(
                                    id: blog.id,
                                    title: blog.title,
                                    content: blog.content,
                                    imageUrl: blog.imageUrl,
                                    createdAt: blog.createdAt,
                                    updatedAt: blog.updatedAt,
                                    status: blog.status,
                                    isDeleted: blog.isDeleted,
                                    author: blog.author,
                                    likes: blog.likes,
                                    comments: blog.comments,
                                    likesCount: blog.likesCount - 1,
                                    commentsCount: blog.commentsCount,
                                  );
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
    );
  }
}
