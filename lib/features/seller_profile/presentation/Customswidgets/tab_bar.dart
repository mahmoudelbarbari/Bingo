// import 'package:flutter/material.dart';
// import 'package:testapp/featuers/seller_profile/domain/entities/event.dart';
// import 'package:testapp/featuers/seller_profile/domain/entities/product.dart';
// import 'package:testapp/featuers/seller_profile/domain/entities/review.dart';
// import 'package:testapp/featuers/seller_profile/presentation/Customswidgets/eventProfile.dart';
// import 'package:testapp/featuers/seller_profile/presentation/Customswidgets/product_tab.dart';
// import 'package:testapp/featuers/seller_profile/presentation/Customswidgets/review.dart';




// class SellerProfileTabs extends StatelessWidget {
//   final TabController tabController;
//   final List<Product> products;
//   final List<Event> events;
//   final List<Review> reviews;

//   const SellerProfileTabs({
//     super.key,
//     required this.tabController,
//     required this.products,
//     required this.events,
//     required this.reviews,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         TabBar(
//           controller: tabController,
//           indicatorColor: Colors.deepPurple,
//           labelColor: Colors.deepPurple,
//           unselectedLabelColor: Colors.grey,
//           tabs: const [
//             Tab(text: 'المنتجات'),
//             Tab(text: 'الفعاليات'),
//             Tab(text: 'التقييمات'),
//           ],
//         ),
//         Expanded(
//           child: TabBarView(
//             controller: tabController,
//             children: [
         
//               products.isEmpty
//                   ? const Center(child: Text("لا توجد منتجات"))
//                   : ListView.builder(
//                       itemCount: products.length,
//                       itemBuilder: (context, index) {
//                         final product = products[index];
//                         return ListTile(
//                           title: Text(product.name),
//                           subtitle: Text(product.description),
//                         );
//                       },
//                     ),

        
//               events.isEmpty
//                   ? const Center(child: Text("لا توجد فعاليات"))
//                   : ListView.builder(
//                       itemCount: events.length,
//                       itemBuilder: (context, index) {
//                         final event = events[index];
//                         return ListTile(
//                           title: Text(event.title),
//                           subtitle: Text(event.description),
//                         );
//                       },
//                     ),

          
//               reviews.isEmpty
//                   ? const Center(child: Text("لا توجد تقييمات"))
//                   : ListView.builder(
//                       itemCount: reviews.length,
//                       itemBuilder: (context, index) {
//                         final review = reviews[index];
//                         return ListTile(
//                           title: Text(review.reviewerName),
//                           subtitle: Text(review.comment),
//                           trailing: Text("${review.rating}/5"),
//                         );
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // class SellerProfileTabs extends StatelessWidget {
// //   final List<Product> products;
// //   final List<Event> events;
// //   final List<Review> reviews;
// //   final TabController tabController;

// //   const SellerProfileTabs({
// //     super.key,
// //     required this.products,
// //     required this.events,
// //     required this.reviews,
// //     required this.tabController,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         TabBar(
// //           controller: tabController,
// //           labelColor: Colors.black,
// //           tabs: const [
// //             Tab(text: 'Products'),
// //             Tab(text: 'Events'),
// //             Tab(text: 'Reviews'),
// //           ],
// //         ),
// //         const SizedBox(height: 8),
    
// //         SizedBox(
// //           height: MediaQuery.of(context).size.height * 0.6, // Adjust as needed
// //           child: TabBarView(
// //             controller: tabController,
// //             children: [
// //               ProductsTab(products: products),
// //               EventsTab(events: events),
// //               ReviewsTab(reviews: reviews),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
