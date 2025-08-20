import 'package:flutter/material.dart';
import '../../data/models/blog_model.dart';
import '../../data/services/blog_api_service.dart';
import '../widgets/comment_item_widget.dart';
import '../widgets/add_comment_widget.dart';

class CommentsPage extends StatefulWidget {
  final BlogModel blog;
  final int blogIndex;
  final VoidCallback? onIncrementComment;

  const CommentsPage({
    Key? key,
    required this.blog,
    required this.blogIndex,
    this.onIncrementComment,
  }) : super(key: key);

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final BlogApiService _blogApiService = BlogApiService();
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  List<BlogComment> _comments = [];
  bool _isLoading = true;
  bool _isAddingComment = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadComments() {
    setState(() {
      _comments = List.from(widget.blog.comments);
      _isLoading = false;
    });
  }

  Future<void> _addComment() async {
    final content = _commentController.text.trim();
    if (content.isEmpty) return;

    setState(() {
      _isAddingComment = true;
    });

    try {
      final newComment = await _blogApiService.addComment(widget.blog.id, content);
      setState(() {
        _comments.insert(0, newComment);
        _commentController.clear();
      });
      // Inform the parent/BLoC via callback to increment the comments count
      widget.onIncrementComment?.call();
      
      // Scroll to top to show new comment
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment added successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding comment: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isAddingComment = false;
      });
    }
  }

  Future<void> _updateComment(String commentId, String newContent) async {
    try {
      final updatedComment = await _blogApiService.updateComment(commentId, newContent);
      setState(() {
        final index = _comments.indexWhere((c) => c.id == commentId);
        if (index != -1) {
          _comments[index] = updatedComment;
        }
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment updated successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating comment: ${e.toString()}')),
      );
    }
  }

  Future<void> _deleteComment(String commentId) async {
    try {
      await _blogApiService.deleteComment(commentId);
      setState(() {
        _comments.removeWhere((c) => c.id == commentId);
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting comment: ${e.toString()}')),
      );
    }
  }

  Future<void> _reportComment(String commentId, String reason, String? description) async {
    try {
      await _blogApiService.reportComment(commentId, reason, description: description);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comment reported successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reporting comment: ${e.toString()}')),
      );
    }
  }

  void _showReportDialog(String commentId) {
    final descriptionController = TextEditingController();
    String selectedReason = 'Inappropriate content';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report Comment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedReason,
              decoration: InputDecoration(labelText: 'Reason'),
              items: [
                'Inappropriate content',
                'Spam',
                'Harassment',
                'False information',
                'Other',
              ].map((reason) => DropdownMenuItem(
                value: reason,
                child: Text(reason),
              )).toList(),
              onChanged: (value) {
                selectedReason = value!;
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description (Optional)',
                hintText: 'Provide additional details...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _reportComment(
                commentId,
                selectedReason,
                descriptionController.text.trim().isEmpty 
                    ? null 
                    : descriptionController.text.trim(),
              );
            },
            child: Text('Report'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comment'),
      ),
      bottomNavigationBar: AddCommentWidget(
        controller: _commentController,
        isLoading: _isAddingComment,
        onSubmit: _addComment,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _comments.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.comment_outlined,
                        size: 64,
                        color: Colors.grey[400],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'No comments yet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Be the first to comment!',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: _comments.length,
                  itemBuilder: (context, index) {
                    final comment = _comments[index];
                    return CommentItemWidget(
                      comment: comment,
                      onUpdate: (newContent) => _updateComment(comment.id, newContent),
                      onDelete: () => _deleteComment(comment.id),
                      onReport: () => _showReportDialog(comment.id),
                    );
                  },
                ),
    );
  }
}
