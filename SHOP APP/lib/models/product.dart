class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final double price;
  final String currency;
  final String image;
  final Map<String, dynamic> specs;

  Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.currency,
    required this.image,
    required this.specs,
  });

  /// WantAPI price format: "$999" veya "$1,299"
  static double _parsePrice(dynamic value) {
    if (value == null) return 0;
    final str = value.toString().replaceAll(RegExp(r'[\$,]'), '').trim();
    return double.tryParse(str) ?? 0;
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    final specs = json['specs'];
    return Product(
      id: json['id'] as int,
      name: json['name'] as String? ?? '',
      tagline: json['tagline'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: _parsePrice(json['price']),
      currency: json['currency'] as String? ?? 'USD',
      image: json['image'] as String? ?? '',
      specs: specs is Map<String, dynamic> ? specs : <String, dynamic>{},
    );
  }

  /// Fake Store API formatı (yedek)
  factory Product.fromFakeStoreJson(Map<String, dynamic> json) {
    final rating = json['rating'];
    final rate = rating is Map ? (rating['rate'] as num?)?.toDouble() ?? 0 : 0.0;
    final count = rating is Map ? (rating['count'] as int?) ?? 0 : 0;
    return Product(
      id: json['id'] as int,
      name: json['title'] as String? ?? '',
      tagline: '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: 'USD',
      image: json['image'] as String? ?? '',
      specs: {'rating': '$rate', 'reviews': '$count'},
    );
  }

  /// DummyJSON API formatı (https://dummyjson.com/products)
  factory Product.fromDummyJson(Map<String, dynamic> json) {
    final images = json['images'];
    final imageList = images is List && images.isNotEmpty
        ? images[0].toString()
        : json['thumbnail']?.toString() ?? '';
    final rating = (json['rating'] as num?)?.toDouble() ?? 0;
    final brand = json['brand'] as String? ?? '';
    final category = json['category'] as String? ?? '';
    final stock = json['stock'];
    return Product(
      id: json['id'] as int,
      name: json['title'] as String? ?? '',
      tagline: brand,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0,
      currency: 'USD',
      image: imageList,
      specs: {
        if (rating > 0) 'rating': rating.toStringAsFixed(1),
        if (brand.isNotEmpty) 'brand': brand,
        if (category.isNotEmpty) 'category': category,
        if (stock != null) 'stock': stock.toString(),
      },
    );
  }

  String get formattedPrice => '$currency ${price.toStringAsFixed(2)}';
}
