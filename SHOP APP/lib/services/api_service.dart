import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

/// Ana kaynak: DummyJSON (https://dummyjson.com/products) - derste kullanılmamış alternatif API
class ApiService {
  static const String dummyJsonUrl = 'https://dummyjson.com';
  static const String fakeStoreUrl = 'https://fakestoreapi.com';

  Future<List<Product>> getProducts({int limit = 30, int skip = 0}) async {
    try {
      final response = await http
          .get(Uri.parse('$dummyJsonUrl/products?limit=$limit&skip=$skip'))
          .timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final products = body['products'] as List<dynamic>?;
        if (products == null) throw Exception('Geçersiz yanıt');
        return products
            .map((e) => Product.fromDummyJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {
      // DummyJSON ulaşılamazsa Fake Store yedek
    }

    final response = await http.get(Uri.parse('$fakeStoreUrl/products'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((e) => Product.fromFakeStoreJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception('Ürünler yüklenemedi. İnternet bağlantınızı kontrol edin.');
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await http
          .get(Uri.parse('$dummyJsonUrl/products/$id'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body) as Map<String, dynamic>;
        return Product.fromDummyJson(jsonMap);
      }
    } catch (_) {}

    final products = await getProducts(limit: 100);
    try {
      return products.firstWhere((p) => p.id == id);
    } on StateError {
      throw Exception('Ürün bulunamadı');
    }
  }

  /// Kategoriler: her biri { 'slug': '...', 'name': '...' } (slug API için, name gösterim için)
  Future<List<Map<String, String>>> getCategories() async {
    try {
      final response = await http
          .get(Uri.parse('$dummyJsonUrl/products/categories'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) {
          final m = e as Map<String, dynamic>;
          return <String, String>{
            'slug': (m['slug'] ?? '').toString(),
            'name': (m['name'] ?? m['slug'] ?? '').toString(),
          };
        }).toList();
      }
    } catch (_) {}
    return [];
  }

  Future<List<Product>> searchProducts(String query) async {
    if (query.trim().isEmpty) return getProducts();
    try {
      final encoded = Uri.encodeComponent(query.trim());
      final response = await http
          .get(Uri.parse('$dummyJsonUrl/products/search?q=$encoded'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final products = body['products'] as List<dynamic>?;
        if (products == null) return [];
        return products
            .map((e) => Product.fromDummyJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  Future<List<Product>> getProductsByCategory(String categorySlug) async {
    try {
      final encoded = Uri.encodeComponent(categorySlug);
      final response = await http
          .get(Uri.parse('$dummyJsonUrl/products/category/$encoded'))
          .timeout(const Duration(seconds: 10));
      if (response.statusCode == 200) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        final products = body['products'] as List<dynamic>?;
        if (products == null) return [];
        return products
            .map((e) => Product.fromDummyJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }
}
