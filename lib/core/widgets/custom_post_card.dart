import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import '../../features/blog/data/models/blog_model.dart';
import '../service/current_user_service.dart';

class PostCardWidget extends StatefulWidget {
  final BlogModel blog;
  final VoidCallback? onCommentTap;
  final Function(bool isLiked)? onLikeChanged;

  const PostCardWidget({
    Key? key,
    required this.blog,
    this.onCommentTap,
    this.onLikeChanged,
  }) : super(key: key);

  @override
  State<PostCardWidget> createState() => _PostCardWidgetState();
}

class _PostCardWidgetState extends State<PostCardWidget> {
  bool _isLiked = false;
  bool _isLikeLoading = false;
  int _likesCount = 0;

  @override
  void initState() {
    super.initState();
    _likesCount = widget.blog.likesCount;
    _initLikeState();
  }

  @override
  void didUpdateWidget(covariant PostCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // When BLoC updates the blog instance, sync local state
    if (oldWidget.blog.id != widget.blog.id ||
        oldWidget.blog.likesCount != widget.blog.likesCount ||
        oldWidget.blog.likes.length != widget.blog.likes.length) {
      _likesCount = widget.blog.likesCount;
      _initLikeState();
      // Re-enable like button after external update
      if (_isLikeLoading) {
        setState(() {
          _isLikeLoading = false;
        });
      }
    }
  }

  Future<void> _initLikeState() async {
    try {
      final currentUserId = await CurrentUserService.getCurrentUserId();
      if (!mounted) return;
      if (currentUserId != null) {
        final liked = widget.blog.likes.any((like) => like.user.id == currentUserId);
        setState(() {
          _isLiked = liked;
        });
      }
    } catch (_) {
      // ignore
    }
  }

  // Remove <img ...> tags and other HTML from Quill HTML to keep text-only in preview
  String _stripImagesAndHtml(String html) {
    final noImgs = html.replaceAll(RegExp(r'<img[^>]*>', caseSensitive: false), '');
    final normalized = noImgs
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'<[^>]+>'), '');
    return normalized.trim();
  }

  // Extract the first <img src="..."> URL from the HTML content
  String? _extractFirstImageUrlFromHtml(String html) {
    // Use a captured quote (" or ') and backreference to ensure we extract a balanced src value
    final match = RegExp('<img[^>]+src=(["\'])(.*?)\\1', caseSensitive: false)
        .firstMatch(html);
    return match != null ? match.group(2) : null;
  }

  Future<void> _toggleLike() async {
    if (_isLikeLoading) return;
    // Delegate the action to the parent (BLoC). Optimistically disable the button.
    setState(() {
      _isLikeLoading = true;
      // Optimistic UI update
      _isLiked = !_isLiked;
      _likesCount = _isLiked ? _likesCount + 1 : (_likesCount > 0 ? _likesCount - 1 : 0);
    });
    // Notify parent/BLoC
    widget.onLikeChanged?.call(_isLiked);
    // Re-enable immediately to avoid spinner lock in case of errors; BLoC update will resync
    if (mounted) {
      setState(() {
        _isLikeLoading = false;
      });
    }
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return Card(
      margin: EdgeInsets.all(25),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                widget.blog.author.name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              subtitle: Text(
                "Posted ${_formatTimeAgo(widget.blog.createdAt)}",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.withOpacity(.5),
                ),
              ),
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: widget.blog.author.shop?.avatar?.url != null
                    ? NetworkImage(widget.blog.author.shop!.avatar!.url)
                    : AssetImage('assets/images/default_avatar.png') as ImageProvider,
              ),
            ),
            if (widget.blog.title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  widget.blog.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(left: 22, right: 22),
              child: ReadMoreText(
                _stripImagesAndHtml(widget.blog.content),
                trimLines: 3,
                trimExpandedText: 'Show Less',
                lessStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFAF1239),
                ),
                trimCollapsedText: 'Read More',
                moreStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFAF1239),
                ),
              ),
            ),
            // Show the main image after the content: use imageUrl, or fallback to first <img> in HTML content
            Builder(
              builder: (_) {
                final fallbackFromHtml = _extractFirstImageUrlFromHtml(widget.blog.content);
                final displayUrl = widget.blog.imageUrl ?? fallbackFromHtml;
                if (displayUrl == null || displayUrl.isEmpty) return SizedBox.shrink();
                return Container(
                  margin: EdgeInsets.all(15),
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(displayUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: _isLikeLoading ? null : _toggleLike,
                    icon: _isLikeLoading
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Icon(
                            _isLiked ? Icons.favorite : Icons.favorite_border_outlined,
                            color: _isLiked ? Colors.red : Colors.grey,
                          ),
                  ),
                  Text(
                    '$_likesCount ${loc!.loveIt}',
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(width: 12),
                  IconButton(
                    onPressed: widget.onCommentTap,
                    icon: Icon(Icons.insert_comment_outlined, color: Colors.grey),
                  ),
                  Text(
                    '${widget.blog.commentsCount} ${loc.comment}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
