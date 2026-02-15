# SHOP APP Flutter Uygulaması

Basit bir e-ticaret uygulaması. Ürün verileri ve görseller **dummyjson** (https://dummyjson.com) üzerinden alınır.

## Özellikler

- **Anasayfa:** Öne çıkan ürünler, "Tüm ürünlere git" butonu
- **Ürünler:** Tüm ürünler (WantAPI’den görselli liste)
- **Ürün detayı:** İsim, tagline, fiyat, açıklama, özellikler (specs), sepete ekleme
- **Alışveriş sepeti:** Ürün ekleme/çıkarma, adet güncelleme, toplam tutar
- **Profil:** Örnek profil sayfası (Hesap, Adresler, Siparişler, Ayarlar)

## Çalıştırma

```bash
flutter pub get
flutter run
```

Android için internet izni `AndroidManifest.xml` içinde tanımlıdır.

## Proje Yapısı

- `lib/models/product.dart` — Ürün modeli
- `lib/services/api_service.dart` — Fake Store API istekleri
- `lib/providers/cart_provider.dart` — Sepet state (Provider)
- `lib/screens/` — Anasayfa, Ürünler, Ürün Detayı, Sepet, Profil ekranları
- `lib/main.dart` — Uygulama girişi ve alt sekmeli navigasyon

## API

Ürünler ve görseller şu adresten çekilir: `https://dummyjson.com`  
Ürünler ve görseller yedek adrestten çekebilirsiniz: `https://fakestoreapi.com` 
Yanıtta her ürün için `id`, `name`, `tagline`, `description`, `price`, `currency`, `image` (URL) ve `specs` bulunur. Karşı tarafın erişebilmesi için veri bu public API üzerinden sağlanır.
hazırlayan [Servet ALAV]
# SHOP-APP
