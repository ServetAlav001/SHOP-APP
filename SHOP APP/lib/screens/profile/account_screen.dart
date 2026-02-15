import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hesap Bilgileri'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _InfoCard(
            title: 'Ad Soyad',
            value: 'Misafir Kullanıcı',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'E-posta',
            value: 'misafir@ornek.com',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 12),
          _InfoCard(
            title: 'Telefon',
            value: '+90 5XX XXX XX XX',
            icon: Icons.phone_outlined,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bilgileri düzenleme henüz aktif değil')),
              );
            },
            icon: const Icon(Icons.edit),
            label: const Text('Bilgileri Düzenle'),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
