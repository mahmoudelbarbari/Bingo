import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/models/blog_model.dart';
import '../../../../core/service/current_user_service.dart';
import '../../data/services/blog_api_service.dart';

// Events
abstract class BlogEvent extends Equatable {
  const BlogEvent();

  @override
  List<Object> get props => [];
}

class IncrementCommentCountEvent extends BlogEvent {
  final int blogIndex;

  const IncrementCommentCountEvent({required this.blogIndex});

  @override
  List<Object> get props => [blogIndex];
}

class LoadBlogsEvent extends BlogEvent {}

class RefreshBlogsEvent extends BlogEvent {}

class ToggleLikeEvent extends BlogEvent {
  final String blogId;
  final int blogIndex;

  const ToggleLikeEvent({required this.blogId, required this.blogIndex});

  @override
  List<Object> get props => [blogId, blogIndex];
}

class AddCommentEvent extends BlogEvent {
  final String blogId;
  final String content;
  final int blogIndex;

  const AddCommentEvent({
    required this.blogId,
    required this.content,
    required this.blogIndex,
  });

  @override
  List<Object> get props => [blogId, content, blogIndex];
}

// States
abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;

  const BlogLoaded({required this.blogs});

  @override
  List<Object> get props => [blogs];
}

class BlogError extends BlogState {
  final String message;

  const BlogError({required this.message});

  @override
  List<Object> get props => [message];
}

class BlogLikeToggling extends BlogState {
  final List<BlogModel> blogs;
  final int blogIndex;

  const BlogLikeToggling({required this.blogs, required this.blogIndex});

  @override
  List<Object> get props => [blogs, blogIndex];
}

// BLoC
class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogApiService _blogApiService;

  BlogBloc({required BlogApiService blogApiService})
      : _blogApiService = blogApiService,
        super(BlogInitial()) {
    on<LoadBlogsEvent>(_onLoadBlogs);
    on<RefreshBlogsEvent>(_onRefreshBlogs);
    on<ToggleLikeEvent>(_onToggleLike);
    on<AddCommentEvent>(_onAddComment);
    on<IncrementCommentCountEvent>(_onIncrementCommentCount);
  }

  Future<void> _onLoadBlogs(LoadBlogsEvent event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      final blogs = await _blogApiService.getAllPublishedBlogs();
      emit(BlogLoaded(blogs: blogs));
    } catch (e) {
      emit(BlogError(message: e.toString()));
    }
  }

  Future<void> _onRefreshBlogs(RefreshBlogsEvent event, Emitter<BlogState> emit) async {
    try {
      final blogs = await _blogApiService.getAllPublishedBlogs();
      emit(BlogLoaded(blogs: blogs));
    } catch (e) {
      emit(BlogError(message: e.toString()));
    }
  }

  Future<void> _onToggleLike(ToggleLikeEvent event, Emitter<BlogState> emit) async {
    if (state is BlogLoaded) {
      final currentState = state as BlogLoaded;
      final blogs = List<BlogModel>.from(currentState.blogs);
      
      emit(BlogLikeToggling(blogs: blogs, blogIndex: event.blogIndex));
      
      try {
        final result = await _blogApiService.toggleLike(event.blogId);
        final isLiked = result['liked'];
        final currentUserId = await CurrentUserService.getCurrentUserId();
        
        // Update the blog in the list
        final updatedBlog = blogs[event.blogIndex];
        // Update likes list so UI can re-initialize correctly on rebuild
        List<BlogLike> updatedLikes = List<BlogLike>.from(updatedBlog.likes);
        if (currentUserId != null) {
          if (isLiked) {
            final already = updatedLikes.any((l) => l.user.id == currentUserId);
            if (!already) {
              updatedLikes.add(
                BlogLike(
                  id: '',
                  user: BlogUser(id: currentUserId, name: '', avatar: null),
                ),
              );
            }
          } else {
            updatedLikes.removeWhere((l) => l.user.id == currentUserId);
          }
        }
        blogs[event.blogIndex] = BlogModel(
          id: updatedBlog.id,
          title: updatedBlog.title,
          content: updatedBlog.content,
          imageUrl: updatedBlog.imageUrl,
          createdAt: updatedBlog.createdAt,
          updatedAt: updatedBlog.updatedAt,
          status: updatedBlog.status,
          isDeleted: updatedBlog.isDeleted,
          author: updatedBlog.author,
          likes: updatedLikes,
          comments: updatedBlog.comments,
          likesCount: isLiked 
              ? updatedBlog.likesCount + 1 
              : (updatedBlog.likesCount > 0 ? updatedBlog.likesCount - 1 : 0),
          commentsCount: updatedBlog.commentsCount,
        );
        
        emit(BlogLoaded(blogs: blogs));
      } catch (e) {
        emit(BlogLoaded(blogs: blogs)); // Revert to original state
        // You might want to show an error message here
      }
    }
  }

  Future<void> _onAddComment(AddCommentEvent event, Emitter<BlogState> emit) async {
    if (state is BlogLoaded) {
      final currentState = state as BlogLoaded;
      final blogs = List<BlogModel>.from(currentState.blogs);
      
      try {
        await _blogApiService.addComment(event.blogId, event.content);
        
        // Update the comment count
        final updatedBlog = blogs[event.blogIndex];
        blogs[event.blogIndex] = BlogModel(
          id: updatedBlog.id,
          title: updatedBlog.title,
          content: updatedBlog.content,
          imageUrl: updatedBlog.imageUrl,
          createdAt: updatedBlog.createdAt,
          updatedAt: updatedBlog.updatedAt,
          status: updatedBlog.status,
          isDeleted: updatedBlog.isDeleted,
          author: updatedBlog.author,
          likes: updatedBlog.likes,
          comments: updatedBlog.comments,
          likesCount: updatedBlog.likesCount,
          commentsCount: updatedBlog.commentsCount + 1,
        );
        
        emit(BlogLoaded(blogs: blogs));
      } catch (e) {
        emit(BlogLoaded(blogs: blogs)); // Revert to original state
        // You might want to show an error message here
      }
    }
  }

  void _onIncrementCommentCount(IncrementCommentCountEvent event, Emitter<BlogState> emit) {
    if (state is BlogLoaded) {
      final currentState = state as BlogLoaded;
      final blogs = List<BlogModel>.from(currentState.blogs);
      final updatedBlog = blogs[event.blogIndex];
      blogs[event.blogIndex] = BlogModel(
        id: updatedBlog.id,
        title: updatedBlog.title,
        content: updatedBlog.content,
        imageUrl: updatedBlog.imageUrl,
        createdAt: updatedBlog.createdAt,
        updatedAt: updatedBlog.updatedAt,
        status: updatedBlog.status,
        isDeleted: updatedBlog.isDeleted,
        author: updatedBlog.author,
        likes: updatedBlog.likes,
        comments: updatedBlog.comments,
        likesCount: updatedBlog.likesCount,
        commentsCount: updatedBlog.commentsCount + 1,
      );
      emit(BlogLoaded(blogs: blogs));
    }
  }
}
