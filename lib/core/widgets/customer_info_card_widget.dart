import 'package:flutter/material.dart';

class CustomerInfoCard extends StatelessWidget {
  final String address;
  final String date;
  final String customerName;
  final String remainingTime;

  const CustomerInfoCard({
    Key? key,
    required this.address,
    required this.date,
    required this.customerName,
    required this.remainingTime,
  }) : super(key: key);

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.teal, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text: '$label : ',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow(Icons.location_on_outlined, 'Address', address),
          _buildInfoRow(Icons.date_range_outlined, 'Date', date),
          _buildInfoRow(Icons.person_outline, 'Customer Name', customerName),
          _buildInfoRow(
            Icons.access_alarm_outlined,
            'Remaining Time',
            remainingTime,
          ),
        ],
      ),
    );
  }
}
