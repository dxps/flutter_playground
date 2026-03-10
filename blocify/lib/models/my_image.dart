class MyImage {
  final String url;
  final double size;

  MyImage({required this.url, required this.size});

  factory MyImage.fromJson(Map<String, dynamic> json) {
    return MyImage(
      url: json['url'],
      size: json['size'],
    );
  }
}
