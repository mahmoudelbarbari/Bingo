class SellerProfile {
  final String name;
  final String coverBanner;
  final String imageUrl;
  final String bio;
  final bool isVerified;

  SellerProfile({
    required this.name,
    required this.coverBanner,
    required this.imageUrl,
    required this.bio,
    required this.isVerified,
  });

  String get firstImageUrl {
    final url = imageUrl;
    if (url.startsWith('http')) return url;
    return 'https://ik.imagekit.io/zeyuss/$url';
  }

  String get firstImageUrlBanner {
    final url = coverBanner;
    if (url.startsWith('http')) return url;
    return 'https://ik.imagekit.io/zeyuss/$url';
  }
}
