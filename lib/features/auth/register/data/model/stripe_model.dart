class StripeModel {
  final String status;
  final String message;
  final String? url;

  StripeModel({required this.status, required this.message, this.url});

  factory StripeModel.fromJson(Map<String, dynamic> json) {
    return StripeModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'message': message, 'url': url};
  }
}
