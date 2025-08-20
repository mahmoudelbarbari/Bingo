import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/widgets/custom_post_card.dart';
import '../../data/services/blog_api_service.dart';
import '../bloc/blog_bloc.dart';
import 'comments_page.dart';

class BlogListPageWithBloc extends StatelessWidget {
  const BlogListPageWithBloc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(blogApiService: BlogApiService())
        ..add(LoadBlogsEvent()),
      child: const _BlogListView(),
    );
  }
}

class _BlogListView extends StatelessWidget {
  const _BlogListView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Posts'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              context.read<BlogBloc>().add(RefreshBlogsEvent());
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: BlocBuilder<BlogBloc, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return Center(child: CircularProgressIndicator());
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
                    'Error loading blogs',
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
                  ElevatedButton(
                    onPressed: () {
                      context.read<BlogBloc>().add(LoadBlogsEvent());
                    },
                    child: Text('Retry'),
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
              );
            }
            
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BlogBloc>().add(RefreshBlogsEvent());
              },
              child: ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
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
              ),
            );
          }
          
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
