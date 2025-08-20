// Example of how to integrate the blog functionality into your existing app

import 'package:flutter/material.dart';
import 'presentation/pages/blog_list_page_with_bloc.dart';
import 'presentation/pages/blog_list_page.dart';

class BlogIntegrationExample extends StatelessWidget {
  const BlogIntegrationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Integration Examples'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Choose your preferred implementation:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            
            // Option 1: Simple StatefulWidget approach
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogListPage(),
                  ),
                );
              },
              child: Text('Simple Blog List (StatefulWidget)'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            
            SizedBox(height: 12),
            
            // Option 2: BLoC approach
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogListPageWithBloc(),
                  ),
                );
              },
              child: Text('Blog List with BLoC (Recommended)'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
            
            SizedBox(height: 24),
            
            Text(
              'Integration Steps:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 12),
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStep(
                      '1.',
                      'Add BLOG_BASE_URL to your .env file',
                      'BLOG_BASE_URL=https://your-backend-url.com/api/blogs',
                    ),
                    _buildStep(
                      '2.',
                      'Add required dependencies to pubspec.yaml',
                      '''dependencies:
  dio: ^5.3.2
  flutter_bloc: ^8.1.3
  equatable: ^2.0.5
  readmore: ^2.2.0''',
                    ),
                    _buildStep(
                      '3.',
                      'Import and use in your app',
                      '''// In your main navigation or home screen
import 'package:bingo/features/blog/presentation/pages/blog_list_page_with_bloc.dart';

// Navigate to blog list
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => BlogListPageWithBloc(),
  ),
);''',
                    ),
                    _buildStep(
                      '4.',
                      'Customize the PostCardWidget if needed',
                      'The PostCardWidget is already updated to work with BlogModel data and includes like/comment functionality.',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String number, String title, String description) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
