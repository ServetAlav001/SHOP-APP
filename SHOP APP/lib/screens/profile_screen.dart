import 'package:flutter/material.dart';
import 'profile/account_screen.dart';
import 'profile/addresses_screen.dart';
import 'profile/orders_screen.dart';
import 'profile/favorites_screen.dart';
import 'profile/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 24),
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Icon(
                Icons.person,
                size: 56,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Misafir Kullanıcı',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Örnek e-ticaret uygulaması',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 32),
            _ProfileTile(
              icon: Icons.person_outline,
              title: 'Hesap Bilgileri',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AccountScreen()),
              ),
            ),
            _ProfileTile(
              icon: Icons.location_on_outlined,
              title: 'Adreslerim',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddressesScreen()),
              ),
            ),
            _ProfileTile(
              icon: Icons.receipt_long_outlined,
              title: 'Siparişlerim',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              ),
            ),
            _ProfileTile(
              icon: Icons.favorite_outline,
              title: 'Favorilerim',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              ),
            ),
            _ProfileTile(
              icon: Icons.settings_outlined,
              title: 'Ayarlar',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Çıkış yapıldı')),
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Çıkış Yap'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
