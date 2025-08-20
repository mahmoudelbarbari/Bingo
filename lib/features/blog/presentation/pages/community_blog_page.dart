import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_post_card.dart';
import '../../data/services/blog_api_service.dart';
import '../bloc/blog_bloc.dart';
import 'comments_page.dart';

class CommunityBlogPage extends StatelessWidget {
  const CommunityBlogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(blogApiService: BlogApiService())
        ..add(LoadBlogsEvent()),
      child: const _CommunityBlogView(),
    );
  }
}

class _CommunityBlogView extends StatelessWidget {
  const _CommunityBlogView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text(
                    'Loading community posts...',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }
          
          if (state is BlogError) {
            return Center(
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
                    'Error loading community posts',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<BlogBloc>().add(LoadBlogsEvent());
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Try Again'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }
          
          if (state is BlogLoaded || state is BlogLikeToggling) {
            final blogs = state is BlogLoaded 
                ? state.blogs 
                : (state as BlogLikeToggling).blogs;
                
            if (blogs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.forum_outlined,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Welcome to the Community!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'No posts available yet',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Be the first to share something amazing!',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<BlogBloc>().add(RefreshBlogsEvent());
                      },
                      icon: Icon(Icons.refresh),
                      label: Text('Refresh'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BlogBloc>().add(RefreshBlogsEvent());
              },
              child: CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final blog = blogs[index];
                        return PostCardWidget(
                          blog: blog,
                          onCommentTap: () {
                            final bloc = context.read<BlogBloc>();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (routeCtx) => BlocProvider.value(
                                  value: bloc,
                                  child: CommentsPage(
                                    blog: blog,
                                    blogIndex: index,
                                    onIncrementComment: () {
                                      bloc.add(
                                        IncrementCommentCountEvent(
                                          blogIndex: index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                          onLikeChanged: (isLiked) {
                            context.read<BlogBloc>().add(
                              ToggleLikeEvent(
                                blogId: blog.id,
                                blogIndex: index,
                              ),
                            );
                          },
                        );
                      },
                      childCount: blogs.length,
                    ),
                  ),
                ],
              ),
            );
          }
          
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  
}
