import 'package:flutter/material.dart';

class SubscriptionPlanWidget extends StatelessWidget {
  final String imageURL;
  final String planTitle;
  final String planPrice;
  final String planDesc;
  const SubscriptionPlanWidget({
    super.key,
    required this.imageURL,
    required this.planTitle,
    required this.planPrice,
    required this.planDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFFF1F9FA),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  planTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  planPrice,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  planDesc,
                  style: TextStyle(fontSize: 14, color: Color(0xFF4B4B4B)),
                ),
              ],
            ),
          ),
          Expanded(child: Image.asset(imageURL)),
        ],
      ),
    );
  }
}
